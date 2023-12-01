//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

enum AvatarModes {
    case small, medium, large

    var size: CGFloat {
        switch self {
        case .small:
            return 40
        case .medium:
            return 60
        case .large:
            return 80
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .large:
            return 24.0
        default:
            return size / 2 // Circular for small and medium
        }
    }
}

struct KikiAvatar: View {
    private var imageSize: CGFloat
    private var cornerRadius: CGFloat
    private var image: Image

    init(mode: AvatarModes = .medium, imageSize: CGFloat? = nil, cornerRadius: CGFloat? = nil, image: Image? = nil) {
        self.imageSize = imageSize ?? mode.size
        self.cornerRadius = cornerRadius ?? mode.cornerRadius
        self.image = image ?? Image("DefaultAvatar", bundle: .designSystem)
    }

    var body: some View {
        image
            .resizable()
            .frame(width: self.imageSize, height: self.imageSize)
            .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius))
    }
}

#Preview {
    KikiAvatar(mode: .large)
}
