//
//  SwiftUIView.swift
//  
//
//  Created by Henry Jones on 11/30/23.
//

import SwiftUI

public enum KKFontFamily {
    case DMSans, TitanOne
}

extension Font {
    
    /// Create a font with the large title text style.
    public static var largeTitle: Font {
        return Font.custom("Titan One", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }
    
    /// Create a font with the title text style.
    public static var title: Font {
        return Font.custom("DM Sans", size: UIFont.preferredFont(forTextStyle: .title1).pointSize).weight(.semibold)
    }
    
    /// Create a font with the headline text style.
    public static var headline: Font {
        return Font.custom("DM Sans", size: UIFont.preferredFont(forTextStyle: .headline).pointSize).weight(.semibold)
    }
    
    /// Create a font with the subheadline text style.
    public static var subheadline: Font {
        return Font.custom("DM Sans", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize).weight(.regular)
    }
    
    /// Create a font with the body text style.
    public static var body: Font {
        return Font.custom("DM Sans", size: UIFont.preferredFont(forTextStyle: .body).pointSize).weight(.semibold)
    }
    
    /// Create a font with the callout text style.
    public static var callout: Font {
        return Font.custom("DM Sans", size: UIFont.preferredFont(forTextStyle: .callout).pointSize).weight(.semibold)
    }
    
    /// Create a font with the footnote text style.
    public static var footnote: Font {
        return Font.custom("DM Sans", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize).weight(.semibold)
    }
    
    /// Create a font with the caption text style.
    public static var caption: Font {
        return Font.custom("DM Sans", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize).weight(.semibold)
    }
    
    public static var kkSystem: Font {
        return Font.custom("DM Sans", size: 16).weight(.semibold)
    }
    
    public static func kkSystem(_ size: CGFloat = 16, weight: Font.Weight = .semibold, fontFamily: KKFontFamily = .DMSans) -> Font {
        
        var font: String
        switch (fontFamily) {
        case .DMSans:
            font = "DM Sans"
            break
        case .TitanOne:
            font = "TitanOne"
        }
        
        return Font.custom(font, size: size).weight(weight)
    }
}


public enum CustomFonts {
    public static func registerCustomFonts() {
        for font in [
            "TitanOne-Regular.ttf",
            "DMSans-Thin.ttf",
            "DMSans-SemiBold.ttf",
            "DMSans-Regular.ttf",
            "DMSans-Medium.ttf",
            "DMSans-Light.ttf",
            "DMSans-ExtraLight.ttf",
            "DMSans-ExtraBold.ttf",
            "DMSans-Bold.ttf",
            "DMSans-Black.ttf"
        ] {
            guard let url = Bundle.designSystem.url(forResource: font, withExtension: nil) else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}

extension View {
    /// Attach this to any Xcode Preview's view to have custom fonts displayed
    /// Note: Not needed for the actual app
    public func loadCustomFonts() -> some View {
        CustomFonts.registerCustomFonts()
        return self
    }
}
