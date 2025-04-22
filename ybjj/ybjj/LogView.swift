//
//  LogView.swift
//  ybjj
//
//  Created by Seth Daetwiler on 4/21/25.
//

import Foundation
import SwiftUI

struct LogDrillView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTitleFocused: Bool

    enum DrillCategory: String, CaseIterable, Identifiable {
        case technique, concept, chain, session
        var id: String { rawValue }
        var icon: String {
            switch self {
            case .technique: return "figure.wrestling"
            case .concept: return "lightbulb"
            case .chain: return "link"
            case .session: return "clock"
            }
        }
    }

    class ViewModel: ObservableObject {
        @Published var title: String = ""
        @Published var category: DrillCategory = .technique
        @Published var notes: String = ""
        @Published var duration: Int = 5
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                // MARK: Header
                Text("Log")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                // MARK: Category Picker
                HStack(spacing: 12) {
                    ForEach(DrillCategory.allCases) { category in
                        Button(action: {
                            viewModel.category = category
                        }) {
                            VStack(spacing: 4) {
                                Image(systemName: category.icon)
                                    .font(.headline)
                                Text(category.rawValue.capitalized)
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                viewModel.category == category ? Color.accentColor: Color.clear
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.category == category ? Color.clear : Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .foregroundColor(viewModel.category == category ? Color.textPrimaryInverse : .primary)
                    }
                }
                .frame(maxWidth: .infinity)

                // MARK: Title
                TextField("Title", text: $viewModel.title)
                    .padding(.vertical, 4)
                    .background(Color.clear)
                    .focused($isTitleFocused)
                    .overlay(
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.gray.opacity(0.4))
                            Rectangle()
                                .frame(width: isTitleFocused || !viewModel.title.isEmpty ? nil : 0, height: 1)
                                .foregroundColor(.accent)
                                .animation(.easeInOut(duration: 0.3), value: isTitleFocused)
                        }
                        .padding(.top, 40),
                        alignment: .bottom
                    )
                    .foregroundColor(.primary)

                // MARK: Tags (future)
                TagInputView()

                // MARK: Notes
                TextEditor(text: $viewModel.notes)
                    .frame(height: 120)
                    .padding(4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))

                // MARK: Duration
                if viewModel.category == .session {
                    Stepper("Duration: \(viewModel.duration) min", value: $viewModel.duration, in: 1...120)
                }

                // MARK: Save Button
                
                WideButton(viewModel: WideButton.ViewModel(icon: "checkmark", backgroundColor: .accent, action: {
                    dismiss()
                }))
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    LogDrillView(viewModel: LogDrillView.ViewModel())
}
