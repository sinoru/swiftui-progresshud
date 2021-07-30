//
//  Color.swift
//  
//
//  Created by Jaehong Kang on 2021/07/30.
//

import SwiftUI

extension Color {
    static var systemBackground: Color {
        #if os(macOS)
        Color(NSColor.windowBackgroundColor)
        #else
        Color(UIColor.systemBackground)
        #endif
    }

    static var systemFill: Color {
        Color(white: 122.0 / 255.0, opacity: 0.2)
    }
}
