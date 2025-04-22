import SwiftUI
import Flow

struct Tag: Identifiable, Equatable {
    let id = UUID()
    var name: String
}

struct TagInputView: View {
    
    @State private var tags: [Tag] = []
    @State private var newTagText: String = ""
    @State private var isEditing = false
    @State private var editingTagID: UUID?
    @State private var duplicateTagID: UUID?
    @Namespace private var animationNamespace
    @FocusState private var isTagFieldFocused: Bool
    
    let font = Font.callout
    let iconWidth: CGFloat = 10
    let iconHeight: CGFloat = 10

    var body: some View {
        HFlow {
            // Tag Capsules
            ForEach(tags) { tag in
                HStack(spacing: 4) {
                    Image(systemName: "x.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color.gray)
                        .frame(width: iconWidth * 1.5, height: iconHeight * 1.45)
                        .onTapGesture {
                            tags.removeAll { $0.id == tag.id }
                        }
                    Text(tag.name)
                        .foregroundStyle(Color.textPrimary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    (duplicateTagID == tag.id || editingTagID == tag.id ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.2))
                )
                .clipShape(Capsule())
                .transition(.asymmetric(insertion: .offset(CGSize(width: -30, height: 0)).combined(with: .opacity), removal: .opacity))
                .onTapGesture {
                    newTagText = tag.name
                    editingTagID = tag.id
                    isEditing = true
                    isTagFieldFocused = true
                }
            }
            .animation(.spring, value: tags)
            
            HStack(spacing: 4) {
                Image(systemName: "plus")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: iconWidth, height: iconHeight)
                
                if isEditing {
                    TextField("New tag", text: $newTagText)
                    .textFieldStyle(.plain)
                    .font(font)
                    .focused($isTagFieldFocused)
                    .onSubmit {
                        addTag()
                    }
                } else {
                    Button {
                        isEditing = true
                        isTagFieldFocused = true
                    } label: {
                        Text("Tag")
                            .font(font)
                    }
                    .buttonStyle(.plain)
                }
            }
            .foregroundStyle(Color.textPrimary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(editingTagID != nil ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.2))
            .clipShape(Capsule())
            
            Spacer()
        }
        .onTapGesture {
            if isEditing {
                isEditing = false
                newTagText = ""
                editingTagID = nil
            }
        }
        .animation(.spring(), value: isEditing)
        .animation(.easeInOut, value: duplicateTagID)
        .animation(.easeInOut, value: editingTagID)
    }
    
    private func addTag() {
        let trimmed = newTagText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            newTagText = ""
            return
        }

        if let editingID = editingTagID, let index = tags.firstIndex(where: { $0.id == editingID }) {
            tags[index].name = trimmed
        } else if let existing = tags.first(where: { $0.name.lowercased() == trimmed.lowercased() }) {
            duplicateTagID = existing.id
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                duplicateTagID = nil
            }
        } else {
            tags.append(Tag(name: trimmed))
        }

        newTagText = ""
        isEditing = false
        editingTagID = nil
    }
}

#Preview {
    TagInputView()
        .padding()
}
