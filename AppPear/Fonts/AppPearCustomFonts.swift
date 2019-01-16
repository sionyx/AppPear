//
//  AppPearCustomFonts.swift
//  apppear
//
//  Created by Vadim Balashov on 26.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

/// Custom font protocol for custom controls
public protocol AppPearCustomFonts {
    var customFonts: [String : UIFont] { get }
}

/// Convinient access extension to use AppPearCustomFont with String base enums
extension AppPearCustomFonts {
    public subscript(key: AppPearanceKey) -> UIFont {
        get {
            return customFonts[key.apppearanceKey()] ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
    }
}
