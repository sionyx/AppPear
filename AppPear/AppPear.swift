//
//  AppPear.swift
//  apppear
//
//  Created by Vadim Balashov on 21.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

/// Application Appearance Manager
public class AppPear: NSObject {

    /// Shared instance
    public static var shared: AppPear = {
        return AppPear()
    }()

    private static let animationDuration = 0.2

    private struct WeakViewControllerContainer {
        weak var viewController: UIViewController?
    }

    private var viewControllers: [WeakViewControllerContainer] = []
    private var colorSchemes: [String: AppPearColorScheme] = [:]
    fileprivate var currentColorScheme: AppPearColorScheme? = nil
    private var fonts: [String: AppPearCustomFonts] = [:]
    fileprivate var currentFonts: AppPearCustomFonts? = nil

    private override init() {
        super.init()
    }

    /// Method should be called at very beggining before any UIViewController instanciated
    public static let configure: Void = {
        UIView.swizzleWillMove
        UIViewController.swizzleViewDidLoad
    }()

    /// Method to register named color schemes
    public func register(colorScheme: AppPearColorScheme, for key: AppPearanceKey) {
        colorSchemes[key.apppearanceKey()] = colorScheme
    }

    /// Method to register named font sizes
    public func register(fonts: AppPearCustomFonts, for key: AppPearanceKey) {
        self.fonts[key.apppearanceKey()] = fonts
    }

    /// Method to switch between registered color schemes
    public func switchApppearance(to key: AppPearanceKey, animated: Bool) {
        guard let colorScheme = colorSchemes[key.apppearanceKey()] else {
            return
        }

        currentColorScheme = colorScheme

        for viewControllerContainer in viewControllers {
            if let viewController = viewControllerContainer.viewController {
                viewController.applyColorScheme(colorScheme, animated: animated)
            }
        }
    }

    /// Method to switch between registered font sizes
    public func switchFontSize(to key: AppPearanceKey) {
        guard let fonts = fonts[key.apppearanceKey()] else {
            return
        }

        currentFonts = fonts

        for viewControllerContainer in viewControllers {
            if let viewController = viewControllerContainer.viewController {
                viewController.applyCustomFonts(fonts)
            }
        }
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let view = object as? UIView,
            keyPath == #keyPath(UIView.isHidden) {
            if let currentColorScheme = currentColorScheme {
                view.downcastColorScheme(currentColorScheme, animated: false)
            }
            if let currentFonts = currentFonts {
                view.downcastFonts(currentFonts)
            }
        }
    }

    /// Internal method to register views controller to be notified on color scheme changed
    internal func registerViewController(_ viewController: UIViewController) {
        print("AppPear registers view controller: \(String(describing: type(of: viewController)))")
        if blacklist.contains(String(describing: type(of: viewController))) {
            return
        }

        viewControllers.append(WeakViewControllerContainer(viewController: viewController))

        if let currentColorScheme = currentColorScheme {
            viewController.applyColorScheme(currentColorScheme, animated: false)
        }
        if let currentFonts = currentFonts {
            viewController.applyCustomFonts(currentFonts)
        }
    }

    /// Helper method to apply appearance animated or not
    internal static func applyAppPearance(animated: Bool, block: @escaping (() -> Void)) {
        if animated {
            UIView.animate(withDuration: animationDuration, animations: block)
        }
        else {
            block()
        }
    }

    fileprivate var blacklist: [String] = []

    public func blackListVC(_ type: UIViewController.Type) {
        blacklist.append(String(describing: type))
    }

    public func blackListVC(name: String) {
        blacklist.append(name)
    }
}

extension UIView {
    @objc
    func apppear_willMove(toSuperview newSuperview: UIView?) {
        apppear_willMove(toSuperview: newSuperview)


        let blacklisted: Bool
        if let parentVC = self.parentViewController,
            AppPear.shared.blacklist.contains(String(describing: type(of: parentVC))) {
            blacklisted = true
        }
        else {
            blacklisted = false
        }


        if !blacklisted,
            newSuperview != nil {
            if let currentColorScheme = AppPear.shared.currentColorScheme {
                downcastColorScheme(currentColorScheme, animated: false)
            }
            if let currentFonts = AppPear.shared.currentFonts {
                downcastFonts(currentFonts)
            }
        }

        if self is UITableViewCell {
            if newSuperview != nil {
                addObserver(AppPear.shared, forKeyPath: #keyPath(UIView.isHidden), options: [.new], context: nil)
            }
            else {
                removeObserver(AppPear.shared, forKeyPath: #keyPath(UIView.isHidden))
            }
        }
    }

    fileprivate static let swizzleWillMove: Void = {
        let originalMethod = class_getInstanceMethod(UIView.self, #selector(willMove(toSuperview:)))
        let swizzledMethod = class_getInstanceMethod(UIView.self, #selector(apppear_willMove(toSuperview:)))

        if let originalMethod = originalMethod,
            let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
}

extension UIViewController {
    @objc
    func apppear_viewDidLoad() {
        apppear_viewDidLoad()
        AppPear.shared.registerViewController(self)
    }

    fileprivate static let swizzleViewDidLoad: Void = {
        let originalMethod = class_getInstanceMethod(UIViewController.self, #selector(viewDidLoad))
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, #selector(apppear_viewDidLoad))
        if let originalMethod = originalMethod,
            let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
}
