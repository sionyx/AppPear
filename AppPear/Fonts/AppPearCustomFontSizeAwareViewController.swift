//
//  AppPearCustomFontsAwareViewController.swift
//  apppear
//
//  Created by Vadim Balashov on 26.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

protocol AppPearCustomFontsAwareViewController {
    func applyCustomFonts(_ fonts: AppPearCustomFonts)
}

extension UIViewController: AppPearCustomFontsAwareViewController {
    func applyCustomFonts(_ fonts: AppPearCustomFonts) {
        if let tableVC = self as? UITableViewController {
            for cell in tableVC.tableView.visibleCells {
                cell.downcastFonts(fonts)
            }
            tableVC.tableView.reloadData()
        }
        else {
            view.downcastFonts(fonts)
        }
    }
}

extension UIView {
    func downcastFonts(_ fonts: AppPearCustomFonts) {
        // Try to apply custom font size to custom components
        if let customFontsAwareSelf = self as? AppPearCustomFontsAwareView {
            customFontsAwareSelf.applyCustomFonts(fonts)
            return
        }

        // Apply font size to subviews
        for subview in subviews {
            subview.downcastFonts(fonts)
        }
    }
}
