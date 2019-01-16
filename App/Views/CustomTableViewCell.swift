//
//  CustomTableViewCell.swift
//  apppear
//
//  Created by Vadim Balashov on 25.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell, AppPearCustomColorSchemeAwareView, AppPearCustomFontsAwareView  {

    @IBOutlet weak var customLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func applyCustomColorScheme(_ colorScheme: AppPearCustomColorScheme) {
        backgroundColor = colorScheme[CustomTableCellColors.cellBackground]
        customLabel.textColor = colorScheme[CustomTableCellColors.cellTextColor]
    }

    func applyCustomFonts(_ fontSize: AppPearCustomFonts) {
        customLabel.font = fontSize[CustomFonts.textFont]
    }
}
