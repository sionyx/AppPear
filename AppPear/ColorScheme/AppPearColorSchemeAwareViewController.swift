//
//  AppPearColorSchemeAwareViewController.swift
//  apppear
//
//  Created by Vadim Balashov on 21.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

protocol AppPearColorSchemeAwareViewController {
    func applyColorScheme(_ colorScheme: AppPearColorScheme, animated: Bool)
}

extension UIViewController: AppPearColorSchemeAwareViewController {
    func applyColorScheme(_ colorScheme: AppPearColorScheme, animated: Bool) {
        view.downcastColorScheme(colorScheme, animated: animated)

        AppPear.applyAppPearance(animated: animated) {
            if let customColorScheme = colorScheme as? AppPearCustomColorScheme,
                let customColorSchemeAwareSelf = self as? AppPearCustomColorSchemeAwareViewController {
                customColorSchemeAwareSelf.applyCustomColorScheme(customColorScheme)
            }
            else if let tableVC = self as? UITableViewController,
                let tableViewColorScheme = colorScheme as? AppPearTableViewColorScheme {
                // AppPearTableViewColorScheme is used for UITableViewController
                tableVC.tableView.backgroundColor = tableViewColorScheme.tableViewBackgroundColor
                tableVC.tableView.separatorColor = tableViewColorScheme.tableViewSeparatorColor
            }
            else if let collectionVC = self as? UICollectionViewController,
                let collectionViewColorScheme = colorScheme as? AppPearCollectionViewColorScheme {
                // AppPearCollectionViewColorScheme is used for UICollectionViewController
                collectionVC.collectionView.backgroundColor = collectionViewColorScheme.collectionViewBackgroundColor
            }
            else {
                if self.view.backgroundColor != nil,
                    self.view.backgroundColor != UIColor.clear {
                    self.view.backgroundColor = colorScheme.viewControllerBackground
                }
            }

            self.applayNavigationBarColorScheme(colorScheme)
        }
    }

    func applayNavigationBarColorScheme(_ colorScheme: AppPearColorScheme) {
        self.navigationController?.navigationBar.barStyle = colorScheme.navigationBarStyle
        self.navigationController?.navigationBar.tintColor = colorScheme.navigationBarTextColor
        self.navigationController?.navigationBar.barTintColor = colorScheme.navigationBarBackgroundColor
    }
}


extension UIView {
    func downcastColorScheme(_ colorScheme: AppPearColorScheme, animated: Bool) {

        // Try to apply custom scheme to custom components
        if let customColorScheme = colorScheme as? AppPearCustomColorScheme,
            let customColorSchemeAwareSelf = self as? AppPearCustomColorSchemeAwareView {
            AppPear.applyAppPearance(animated: animated) {
                customColorSchemeAwareSelf.applyCustomColorScheme(customColorScheme)
            }
            // check if should apply color scheme to subviews
            if !customColorSchemeAwareSelf.shouldDowncastCustomColorScheme {
                return
            }
        }

        // Try to apply color scheme to system componentns
        if let colorSchemeAwareSelf = self as? AppPearColorSchemeAwareView {
            AppPear.applyAppPearance(animated: animated) {
                colorSchemeAwareSelf.applyColorScheme(colorScheme)
            }

            // check if should apply color scheme to subviews
            if !colorSchemeAwareSelf.shouldDowncastColorScheme {
                return
            }
        }

        for subview in subviews {
            subview.downcastColorScheme(colorScheme, animated: animated)
        }

        // AppPearCustomColorSchemeAwareView cannot be applied to UIView,
        // so apply color scheme to UIView here as exception
        if type(of: self) == UIView.self,
            parentViewController?.view != self,
            let viewColorScheme = colorScheme as? AppPearViewColorScheme,
            backgroundColor != UIColor.clear {

            AppPear.applyAppPearance(animated: animated) {
                self.backgroundColor = viewColorScheme.viewBackgroundColor
            }
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    private struct AssociatedKey {
        static var key = "skipColorScheme"
    }

    public var skipColorScheme: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.key) as? Bool ?? false
        }
        set {
            if newValue {
                objc_setAssociatedObject(self, &AssociatedKey.key, true, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            else {
                if let obj = objc_getAssociatedObject(self, &AssociatedKey.key) as? Bool {
                    objc_removeAssociatedObjects(obj)
                }
            }
        }
    }
}
