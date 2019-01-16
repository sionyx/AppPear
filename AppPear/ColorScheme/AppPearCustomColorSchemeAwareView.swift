//
//  AppPearCustomColorSchemeAwareView.swift
//  apppear
//
//  Created by Vadim Balashov on 26.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

/// Protocol to apply color schemes to user defined components
public protocol AppPearCustomColorSchemeAwareView {
    /// Method to apply color scheme to custom components
    func applyCustomColorScheme(_ colorScheme: AppPearCustomColorScheme)

    /// Specifies should component downcast color scheme to it's subviews
    var shouldDowncastCustomColorScheme: Bool { get }
}

extension AppPearCustomColorSchemeAwareView {
    /// By default custom componets should not downcast information to it's subviews
    public var shouldDowncastCustomColorScheme: Bool {
        return false
    }
}

