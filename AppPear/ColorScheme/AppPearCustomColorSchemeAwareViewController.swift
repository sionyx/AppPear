//
//  AppPearCustomColorSchemeAwareViewController.swift
//  apppear
//
//  Created by Vadim Balashov on 10.01.2019.
//  Copyright © 2019 sionyx. All rights reserved.
//

import UIKit

/// Protocol to apply custom color schemes to view controllers
public protocol AppPearCustomColorSchemeAwareViewController {
    /// Method to apply color scheme to custom components
    func applyCustomColorScheme(_ colorScheme: AppPearCustomColorScheme)
}
