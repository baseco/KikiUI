//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

struct KikiBlurb: View {
    let mode: KikiCellMode
    let text: String

    init(mode: KikiCellMode = .single, text: String){
        self.mode = mode
        self.text = text
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .padding()
                .font(.kikiFont(12, weight: .semibold, fontFamily: .DMSans))
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: mode == .single ? defaultBorderRadius : 0).fill(Color.white))
    }
}

#Preview {
    KikiBlurb(text:"hello this is me the text").loadCustomFonts()
}
