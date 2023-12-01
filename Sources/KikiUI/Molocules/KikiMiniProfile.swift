//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

struct KikiMiniProfile: View {
    var image: Image?
    var title: String?
    var subtitle: String?
    var note: String?
    let avatarMode: AvatarModes = .large
    
    var body: some View {
        HStack(spacing: 16) {
            KikiAvatar(mode: avatarMode, image: image)
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    if let title = title {
                        Text(title)
                            .font(.kkSystem(16, weight: .black, fontFamily: .DMSans))
                    }
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.kkSystem(12, weight: .semibold, fontFamily: .DMSans))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                    
                    if let note = note {
                        Text(note)
                            .font(.kkSystem(12, weight: .semibold, fontFamily: .DMSans))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(height: geometry.size.height)
            }
            Spacer()
        }
        .frame(height: avatarMode.size)
        .padding()
        .background(Color.white)
    }
}

#Preview {
    KikiMiniProfile(
        title: "Oliver W.",
        subtitle: "@Oliver",
        note: "Oliver Wang from your contacts"
    ).loadCustomFonts()
}
