//
//  AppPearanceKey.swift
//  apppear
//
//  Created by Vadim Balashov on 21.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import Foundation

/// Helper protocol to use string base enums as AppPear keys
public protocol AppPearanceKey {
    func apppearanceKey() -> String
}

extension RawRepresentable where RawValue == String {
    public func apppearanceKey() -> String {
        let str = String(describing: type(of: self)) + rawValue
        return str
    }
}
