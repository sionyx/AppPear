//
//  AppPearColorSchemeAwareView.swift
//  apppear
//
//  Created by Vadim Balashov on 25.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

protocol AppPearColorSchemeAwareView {
    /// Metho to apply color scheme to system components
    func applyColorScheme(_ colorScheme: AppPearColorScheme)

    /// Specifies should component downcast color scheme to it's subviews
    var shouldDowncastColorScheme: Bool { get }
}

extension AppPearColorSchemeAwareView {
    /// By default system componets should not downcast information to it's subviews
    var shouldDowncastColorScheme: Bool {
        return false
    }
}

extension UILabel: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let labelColorScheme = colorScheme as? AppPearLabelColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        textColor = labelColorScheme.labelTextColor
    }
}

extension UIButton: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let buttonColorScheme = colorScheme as? AppPearButtonColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        tintColor = buttonColorScheme.buttonTintColor
    }
}

extension UITableView: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let tableViewColorScheme = colorScheme as? AppPearTableViewColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        backgroundColor = tableViewColorScheme.tableViewBackgroundColor
    }

    var shouldDowncastColorScheme: Bool {
        return true
    }
}

extension UICollectionView: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let collectionViewColorScheme = colorScheme as? AppPearCollectionViewColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        backgroundColor = collectionViewColorScheme.collectionViewBackgroundColor
    }

    var shouldDowncastColorScheme: Bool {
        return true
    }
}

extension UITableViewCell: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let tableViewColorScheme = colorScheme as? AppPearTableViewColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        backgroundColor = tableViewColorScheme.cellBackgroundColor
        textLabel?.textColor = tableViewColorScheme.cellTextColorColor
        detailTextLabel?.textColor = tableViewColorScheme.cellSubTextColorColor
    }

    var shouldDowncastColorScheme: Bool {
        return true
    }
}

extension UITableViewHeaderFooterView: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let tableViewColorScheme = colorScheme as? AppPearTableViewColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        backgroundView?.backgroundColor = tableViewColorScheme.headerBackgroundColor
        textLabel?.textColor = tableViewColorScheme.headerTextColorColor
    }
}

extension UIDatePicker: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let datePickerColorScheme = colorScheme as? AppPearDatePickerColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        setValue(datePickerColorScheme.datePickerTextColor, forKey: "textColor")
    }
}

extension UIRefreshControl: AppPearColorSchemeAwareView {
    func applyColorScheme(_ colorScheme: AppPearColorScheme) {
        guard let refreshControlColorScheme = colorScheme as? AppPearRefreshControlColorScheme else {
            return
        }

        if skipColorScheme {
            return
        }

        tintColor = refreshControlColorScheme.refreshControlTintColor
        titleColor = refreshControlColorScheme.refreshControlTextColor

        updateTitle()
    }

    private struct AssociatedKey {
        static var key = "titleColor"
    }

    public var titleColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.key) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateTitle()
        }
    }

    public var title: String? {
        get {
            return attributedTitle?.string
        }
        set {
            guard let newTitle = newValue else {
                attributedTitle = nil
                return
            }

            attributedTitle = NSAttributedString(string: newTitle)
            updateTitle()
        }
    }

    private func updateTitle() {
        guard let titleColor = titleColor,
            let title = attributedTitle?.string else {
                return
        }

        let attrTitle = NSAttributedString(string: title,
                                           attributes: [ NSAttributedString.Key.foregroundColor : titleColor])
        attributedTitle = attrTitle
    }
}
