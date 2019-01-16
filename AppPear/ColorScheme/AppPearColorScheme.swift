//
//  AppPearColorScheme.swift
//  apppear
//
//  Created by Vadim Balashov on 21.12.2018.
//  Copyright © 2018 sionyx. All rights reserved.
//

import UIKit

/// Base color scheme protocol
public protocol AppPearColorScheme {
    var viewControllerBackground: UIColor { get }
    var navigationBarStyle: UIBarStyle { get }
    var navigationBarBackgroundColor: UIColor { get }
    var navigationBarTextColor: UIColor { get }
}

/// Color scheme protocol specifing UIView background color
public protocol AppPearViewColorScheme {
    var viewBackgroundColor: UIColor { get }
}

/// Color scheme protocol specifing UILabel text color
public protocol AppPearLabelColorScheme {
    var labelTextColor: UIColor { get }
}

/// Color scheme protocol specifing UIButton tint color
public protocol AppPearButtonColorScheme {
    var buttonTintColor: UIColor { get }
}

/// Color scheme protocol specifing UITableView colors
public protocol AppPearTableViewColorScheme {
    var tableViewBackgroundColor: UIColor { get }
    var tableViewSeparatorColor: UIColor { get }
    var headerBackgroundColor: UIColor { get }
    var headerTextColorColor: UIColor { get }
    var cellBackgroundColor: UIColor { get }
    var cellTextColorColor: UIColor { get }
    var cellSubTextColorColor: UIColor { get }
}

/// Color scheme protocol specifing UICollectionView colors
public protocol AppPearCollectionViewColorScheme {
    var collectionViewBackgroundColor: UIColor { get }
    var cellBackgroundColor: UIColor { get }
    var cellTextColorColor: UIColor { get }
    var cellSubTextColorColor: UIColor { get }
}

/// Color scheme protocol specifing UIDatePicker text color
public protocol AppPearDatePickerColorScheme {
    var datePickerTextColor: UIColor { get }
}

/// Color scheme protocol specifing UIRefreshControl text and tint colors
public protocol AppPearRefreshControlColorScheme {
    var refreshControlTintColor: UIColor { get }
    var refreshControlTextColor: UIColor { get }
}
