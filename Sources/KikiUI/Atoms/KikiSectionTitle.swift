//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI
import DesignSystem

struct KikiSectionTitle: View {
    var text: String = "hello world"
    
    var body: some View {
        HStack{
            Text(text)
                .font(.kkSystem(16, weight: .bold, fontFamily: .TitanOne))
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            Spacer()
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 32)
    }
}

#Preview {
    KikiSectionTitle().loadCustomFonts()
}
