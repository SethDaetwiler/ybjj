//
//  Helpers.swift
//  ybjj
//
//  Created by Seth Daetwiler on 4/21/25.
//

import Foundation
import SwiftUI


extension Color {
    
    public static let backgroundPrimary: Color = Color("brandColor")
    
    public static let textPrimary: Color = Color("primaryTextColor")
    public static let textPrimaryInverse: Color = Color("primaryTextColorInverse")
    public static let textSecondary: Color = Color("secondaryTextColor")
    
}

extension View {
    func horizontalPadding() -> some View {
        self.padding(.horizontal, 16)
    }
    
    func contentHorizontalPadding() -> some View {
        self.padding(.horizontal, 8)
    }
}


