//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

// Enum for button modes
enum ButtonMode {
    case primary
    case secondary
    case tertiary
    case warning
    
    var color: Color {
        switch self {
        case .primary:
            return .blue
        case .secondary:
            return .green
        case .tertiary:
            return .purple
        case .warning:
            return .red
        }
    }
}

struct KikiButton: View {
    let action: () -> Void
    let text: String
    let mode: ButtonMode
    
    init(text: String, mode: ButtonMode, action: @escaping () -> Void = {}) {
        self.text = text
        self.mode = mode
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(mode.color)
                .clipShape(Capsule())
                .padding()
        }        
        .background(Color.white)
    }
}

#Preview {
    KikiButton(text: "Add", mode: .primary) {
        // Action for the button goes here
        print("Button tapped")
    }
}
