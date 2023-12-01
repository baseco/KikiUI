//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

enum KikiCellMode {
    case list
    case single
}

struct KikiCellVStack<Content: View>: View {
    private var cornerRadius: CGFloat
    @ViewBuilder let content: Content

    init(cornerRadius: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius ?? defaultBorderRadius
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0.0) {
            content
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct KikiCell<Icon: View, Body: View, Action: View>: View {
    let iconContent: () -> Icon?
    let bodyContent: () -> Body?
    let actionContent: () -> Action?
    let mode: KikiCellMode

    init(mode: KikiCellMode = .single,
         @ViewBuilder icon: @escaping () -> Icon? = { nil },
         @ViewBuilder body: @escaping () -> Body? = { nil },
         @ViewBuilder action: @escaping () -> Action? = { nil }) {
        self.mode = mode
        self.iconContent = icon
        self.bodyContent = body
        self.actionContent = action
    }

    var body: some View {
        HStack {
            if let icon = iconContent() {
                icon
            }

            if let body = bodyContent() {
                body
                Spacer()
            }

            if let action = actionContent() {
                action
            }
        }
        .padding(.horizontal)
        .frame(minHeight: defaultCellHeight)
        .background(RoundedRectangle(cornerRadius: mode == .single ? defaultBorderRadius : 0).fill(Color.white))
    }
}
struct KikiCellExample: View {
    @State private var isOn: Bool = false

    var body: some View {
        KikiCell(
            icon: {
                Image(systemName: "xmark.octagon")
                    .foregroundColor(.gray)
                    .padding(8)
                    .background(Circle().fill(Color.gray.opacity(0.2)))
            },
            body: {
                Text("Block")
                    .font(.title3)
            },
            action: {
                Toggle("", isOn: $isOn)
                    .labelsHidden()
            }
        )
    }
}


#Preview {
    KikiCellExample()
}
