//
//  AppPearCustomColorScheme.swift
//  apppear
//
//  Created by Vadim Balashov on 26.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

/// Color scheme protocol for custom controls
public protocol AppPearCustomColorScheme {
    var customColors: [String : UIColor] { get }
}

/// Convinient access extension to use AppPearCustomColorScheme with String base enums
extension AppPearCustomColorScheme {
    public subscript(key: AppPearanceKey) -> UIColor {
        get {
            return customColors[key.apppearanceKey()] ?? UIColor.black
        }
    }
}
