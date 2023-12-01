//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

struct KikiSettingsCell<Content: View>: View {
    let icon: Image?
    let title: String
    let mode: KikiCellMode
    var onPress: (() -> Void)?
    var content: Content?
    
    @State private var isPressed: Bool = false

    init(icon: Image? = nil, title: String, mode: KikiCellMode = .single, onPress: (() -> Void)? = nil, @ViewBuilder content: () -> Content? = { nil }) {
        self.icon = icon
        self.title = title
        self.mode = mode
        self.onPress = onPress
        self.content = content()
    }
    
    var body: some View {
        Group {
            if let onPress = onPress {
                Button(action: {
                    isPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressed = false
                        onPress()
                    }
                }) {
                    contentBody
                        .opacity(isPressed ? 0.5 : 1.0)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                contentBody
            }
        }
    }
    
    @ViewBuilder
    private var contentBody: some View {
        KikiCell(
            mode: mode,
            icon: {
                KikiBlob {
                    icon?
                        .foregroundColor(.gray)
                        .padding(8)
                }
            },
            body: {
                Text(title)
                    .font(.kkSystem(16, weight: .black, fontFamily: .DMSans))
            },
            action: {
                if let content = content {
                    content
                }
            }
        )
    }
}

#Preview {
    KikiSettingsCell<EmptyView>(icon: Image("phone", bundle: .designSystem), title: "+1 (207) 712-5149", mode: .single).loadCustomFonts()
}

