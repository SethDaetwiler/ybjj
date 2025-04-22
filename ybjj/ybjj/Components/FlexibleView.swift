import SwiftUI
import Flow

struct Tag: Identifiable, Equatable {
    let id = UUID()
    let name: String
}

struct TagInputView: View {
    
    @State private var tags: [Tag] = []
    @State private var newTagText: String = ""
    @State private var isEditing = false
    @Namespace private var animationNamespace

    var body: some View {
        HFlow {
            // Add Tag Button or TextField

            // Tag Capsules
            ForEach(tags) { tag in
                HStack(spacing: 4) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            tags.removeAll { $0.id == tag.id }
                        }
                    Text(tag.name)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.2))
                .clipShape(Capsule())
            }
            
            if isEditing {
                HStack(spacing: 4) {
                    Image(systemName: "plus")
                    TextField("New tag", text: $newTagText, onCommit: {
                        if !newTagText.isEmpty {
                            tags.append(Tag(name: newTagText))
                            newTagText = ""
                        }
                        withAnimation(.spring()) {
                            isEditing = false
                        }
                    })
                    .textFieldStyle(.plain)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.2))
                .clipShape(Capsule())
                .matchedGeometryEffect(id: "tagInput", in: animationNamespace)
            } else {
                Button {
                    withAnimation(.spring()) {
                        isEditing = true
                    }
                } label: {
                    Label("Tag", systemImage: "plus")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .matchedGeometryEffect(id: "tagInput", in: animationNamespace)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    TagInputView()
        .padding()
}
