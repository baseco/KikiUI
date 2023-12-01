//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

struct KikiBlob<Content: View>: View {
    let seed: String
    let index: Int
    let color: Color
    let content: Content

    init(seed: String = "seed", index: Int = 0, color: Color = Color.gray.opacity(0.5), @ViewBuilder content: () -> Content) {
        self.seed = seed
        self.index = index
        self.color = color
        self.content = content()
    }

    private var imageName: String {
        let combined = "\(seed)\(index)"
        let consistentHash = combined.utf8.reduce(0, { $0 * 31 &+ Int($1) })
        let imageIndex = abs(consistentHash) % 4
        return "blob-\(imageIndex)"
    }

    var body: some View {
        content
            .background(
                Image(imageName, bundle: .designSystem)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(color)
                    .aspectRatio(1, contentMode: .fill)
            )
    }
}

#Preview {
    KikiBlob {
        Text("Child View")
            .foregroundColor(.white)
            .padding()
    }
}
