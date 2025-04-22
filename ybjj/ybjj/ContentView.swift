//
//  ContentView.swift
//  ybjj
//
//  Created by Seth Daetwiler on 4/21/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @State var textField: String = ""
    @State private var isLogging = false

    var body: some View {
        ZStack {
            VStack {
                if !isLogging {
                    WideButton(viewModel: WideButton.ViewModel(icon: "plus", backgroundColor: .backgroundPrimary, action: {
                        withAnimation(.spring()) {
                            isLogging.toggle()
                        }
                    }))
                    .horizontalPadding()
                }

                List {
                    // Future: display logged entries
                }
            }
        }
        .padding(.top)
        .sheet(isPresented: $isLogging) {
            LogDrillView(viewModel: LogDrillView.ViewModel())
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
