//
//  ViewController.swift
//  apppear
//
//  Created by Vadim Balashov on 21.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit


// MARK: Color Schemes

enum CustomTableCellColors: String, AppPearanceKey {
    case cellBackground
    case cellTextColor
}

struct lightAppPearance: AppPearColorScheme, AppPearViewColorScheme, AppPearLabelColorScheme, AppPearButtonColorScheme, AppPearTableViewColorScheme, AppPearCustomColorScheme {
    let viewControllerBackground = UIColor.white
    let navigationBarStyle = UIBarStyle.default
    let navigationBarBackgroundColor =  UIColor.white
    let navigationBarTextColor = UIColor.black
    let viewBackgroundColor = UIColor.magenta
    let labelTextColor = UIColor.black
    let buttonTintColor = UIColor.blue

    let tableViewBackgroundColor = UIColor.lightGray
    var tableViewSeparatorColor = UIColor.gray
    let headerBackgroundColor = UIColor.white
    let headerTextColorColor = UIColor.black
    let cellBackgroundColor = UIColor.white
    let cellTextColorColor = UIColor.black
    let cellSubTextColorColor = UIColor.darkGray

    let customColors = [CustomTableCellColors.cellBackground.apppearanceKey() : UIColor.magenta,
                        CustomTableCellColors.cellTextColor.apppearanceKey() : UIColor.purple ]
}

struct darkAppPearance: AppPearColorScheme, AppPearViewColorScheme, AppPearLabelColorScheme, AppPearButtonColorScheme, AppPearTableViewColorScheme, AppPearCustomColorScheme {
    let viewControllerBackground = UIColor.black
    let navigationBarStyle = UIBarStyle.black
    let navigationBarBackgroundColor =  UIColor.black
    let navigationBarTextColor = UIColor.white
    let viewBackgroundColor = UIColor.yellow
    let labelTextColor = UIColor.white
    let buttonTintColor = UIColor.blue

    let tableViewBackgroundColor = UIColor.darkGray
    var tableViewSeparatorColor = UIColor.gray
    let headerBackgroundColor = UIColor.black
    let headerTextColorColor = UIColor.white
    let cellBackgroundColor = UIColor.black
    let cellTextColorColor = UIColor.white
    let cellSubTextColorColor = UIColor.lightGray

    let customColors = [CustomTableCellColors.cellBackground.apppearanceKey() : UIColor.purple,
                        CustomTableCellColors.cellTextColor.apppearanceKey() : UIColor.magenta ]
}

struct blueAppPearance: AppPearColorScheme, AppPearViewColorScheme, AppPearLabelColorScheme, AppPearButtonColorScheme, AppPearTableViewColorScheme, AppPearCustomColorScheme {
    let viewControllerBackground = UIColor.blue
    let navigationBarStyle = UIBarStyle.black
    let navigationBarBackgroundColor =  UIColor.blue
    let navigationBarTextColor = UIColor.white
    let viewBackgroundColor = UIColor.black
    let labelTextColor = UIColor.white
    let buttonTintColor = UIColor.blue

    let tableViewBackgroundColor = UIColor.lightGray
    var tableViewSeparatorColor = UIColor.gray
    let headerBackgroundColor = UIColor.white
    let headerTextColorColor = UIColor.black
    let cellBackgroundColor = UIColor.white
    let cellTextColorColor = UIColor.black
    let cellSubTextColorColor = UIColor.darkGray

    let customColors = [CustomTableCellColors.cellBackground.apppearanceKey() : UIColor.magenta,
                        CustomTableCellColors.cellTextColor.apppearanceKey() : UIColor.purple ]
}

enum AppPearanceTypes: String, AppPearanceKey {
    case light
    case dark
    case blue
}

// MARK: Fonts

enum CustomFonts: String, AppPearanceKey {
    case textFont
    case subtextFont
    case titleFont
}

struct normalFonts: AppPearCustomFonts {
    let customFonts = [CustomFonts.textFont.apppearanceKey()    : UIFont.systemFont(ofSize: 17),
                       CustomFonts.subtextFont.apppearanceKey() : UIFont.systemFont(ofSize: 12),
                       CustomFonts.titleFont.apppearanceKey()   : UIFont.systemFont(ofSize: 22) ]
}

struct largeFonts: AppPearCustomFonts {
    let customFonts = [CustomFonts.textFont.apppearanceKey()    : UIFont.systemFont(ofSize: 20),
                       CustomFonts.subtextFont.apppearanceKey() : UIFont.systemFont(ofSize: 15),
                       CustomFonts.titleFont.apppearanceKey()   : UIFont.systemFont(ofSize: 27) ]
}

enum FontSizes: String, AppPearanceKey {
    case normal
    case large
}



// MARK: View Controler



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {



    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        AppPear.shared.register(colorScheme: lightAppPearance(), for: AppPearanceTypes.light)
        AppPear.shared.register(colorScheme: darkAppPearance(), for: AppPearanceTypes.dark)
        AppPear.shared.register(colorScheme: blueAppPearance(), for: AppPearanceTypes.blue)
        AppPear.shared.switchApppearance(to: AppPearanceTypes.light, animated: false)

        AppPear.shared.register(fonts: normalFonts(), for: FontSizes.normal)
        AppPear.shared.register(fonts: largeFonts(), for: FontSizes.large)
        AppPear.shared.switchFontSize(to: FontSizes.normal)
    }


    @IBAction func appearanceSwitched(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else {
            return
        }

        switch segmentedControl.selectedSegmentIndex {
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
    
    @IBAction func fontsSwitched(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else {
            return
        }

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            AppPear.shared.switchFontSize(to: FontSizes.normal)
        case 1:
            AppPear.shared.switchFontSize(to: FontSizes.large)
        default:
            break
        }
    }

    // MAKR: Table

    private var lines = 1

    @IBAction func addLine(_ sender: Any) {
        lines = lines + 1
        tableView.reloadData()
    }

    @IBAction func RemoveLine(_ sender: Any) {
        if lines > 1 {
            lines = lines - 1
        }

        tableView.reloadData()
    }

    // MARK: UITableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

