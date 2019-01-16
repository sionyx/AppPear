//
//  TableViewController.swift
//  apppear
//
//  Created by Vadim Balashov on 25.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            AppPear.shared.switchApppearance(to: AppPearanceTypes.light, animated: true)
        case 1:
            AppPear.shared.switchApppearance(to: AppPearanceTypes.dark, animated: true)
        case 2:
            AppPear.shared.switchApppearance(to: AppPearanceTypes.blue, animated: true)
        default:
            break
        }
    }
}
