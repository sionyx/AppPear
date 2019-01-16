//
//  AppPearCustomFontsAwareView.swift
//  apppear
//
//  Created by Vadim Balashov on 26.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

/// Protocol to apply fonts to user defined components
public protocol AppPearCustomFontsAwareView {
    /// Method to apply fonts to custom components
    func applyCustomFonts(_ fonts: AppPearCustomFonts)
}
