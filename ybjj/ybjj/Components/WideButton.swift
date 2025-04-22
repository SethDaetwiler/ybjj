//
//  File.swift
//  ybjj
//
//  Created by Seth Daetwiler on 4/21/25.
//

import Foundation
import SwiftUI



struct WideButton: View {
    
    @ObservedObject var viewModel: Self.ViewModel
    
    var body: some View {
        Button(action: viewModel.action) {
            Image(systemName: viewModel.icon)
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
        }
        .background(viewModel.backgroundColor ?? Color.blue)
        .foregroundColor(viewModel.foregroundColor ?? Color.white)
        .cornerRadius(8)
    }
    
    class ViewModel: ObservableObject {
        @Published var icon: String = "plus"
        @Published var backgroundColor: Color? = nil
        @Published var foregroundColor: Color? = nil
        var action: () -> Void = {}
        
        init(icon: String, backgroundColor: Color? = nil, foregroundColor: Color? = nil, action: @escaping () -> Void) {
            self.icon = icon
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.action = action
        }
    }

}

struct WideButton_Previews: PreviewProvider {
    static var previews: some View {
        WideButton(viewModel: {
            
            let icon = "plus"
            let vm = WideButton.ViewModel(icon: icon, action: {})

            return vm
        }())
    }
}
