#  AppPear - swift library for custom application appearance and dynamic theme switching

## Basic Usage

1. Call `AppPear.configure` at very beginning of the app, just after application(: didFinishLaunchingWithOptions:)

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    AppPear.configure
    // Your code here
    return true
}
```

2. Introduce application cpecific color schemes with structs conforming `AppPearColorScheme` protocol

```
struct lightAppPearance: AppPearColorScheme {
    let viewControllerBackground = UIColor.white
    let navigationBarStyle = UIBarStyle.default
    let navigationBarBackgroundColor =  UIColor.white
    let navigationBarTextColor = UIColor.black
}

struct darkAppPearance: AppPearColorScheme {
    let viewControllerBackground = UIColor.black
    let navigationBarStyle = UIBarStyle.black
    let navigationBarBackgroundColor =  UIColor.black
    let navigationBarTextColor = UIColor.white
}
```

3. Describe color scheme names in enum conforming `AppPearanceKey`

```
enum AppPearanceTypes: String, AppPearanceKey {
    case light
    case dark
}
```

4. Register color schemes and switch to actual scheme (can be made in `viewDidLoad()` method of root view controller or at any other place before view controller appeared)

```
AppPear.shared.register(colorScheme: lightAppPearance(), for: AppPearanceTypes.light)
AppPear.shared.register(colorScheme: darkAppPearance(), for: AppPearanceTypes.dark)
AppPear.shared.switchApppearance(to: AppPearanceTypes.light, animated: false)

```

5. That's it, now you can switch between color schemes at any time (do not forget animation)

```
AppPear.shared.switchApppearance(to: AppPearanceTypes.light, animated: true)
```

## UIKit components

1. Expand color scheme structs to make it conform ui-component specific protocols

```
struct lightAppPearance: AppPearColorScheme, AppPearLabelColorScheme, AppPearButtonColorScheme {
    let viewControllerBackground = UIColor.white
    let navigationBarStyle = UIBarStyle.default
    let navigationBarBackgroundColor =  UIColor.white
    let navigationBarTextColor = UIColor.black
    // AppPearLabelColorScheme
    let labelTextColor = UIColor.black
    // AppPearButtonColorScheme
    let buttonTintColor = UIColor.blue
}
```

2. That's it. Check supported UIKit components in `AppPearColorScheme.swift` file

## Color schemes for custom components

1. Introduce enum with custom names to use in color scheme

```
enum CustomTableCellColors: String, AppPearanceKey {
    case cellBackground
    case cellTextColor
}
```

2. Expand color scheme struct to conform `AppPearCustomColorScheme` protocol and add dictionary with custom colors

```
struct lightAppPearance: AppPearColorScheme, AppPearLabelColorScheme, 
                         AppPearButtonColorScheme, AppPearCustomColorScheme {
    let viewControllerBackground = UIColor.white
    let navigationBarStyle = UIBarStyle.default
    let navigationBarBackgroundColor =  UIColor.white
    let navigationBarTextColor = UIColor.black
    // AppPearLabelColorScheme
    let labelTextColor = UIColor.black
    // AppPearButtonColorScheme
    let buttonTintColor = UIColor.blue
    // AppPearCustomColorScheme
    let customColors = [CustomTableCellColors.cellBackground.apppearanceKey() : UIColor.magenta,
                        CustomTableCellColors.cellTextColor.apppearanceKey() : UIColor.purple ]
}
```

3. Make your custom component conform `AppPearCustomColorSchemeAwareView` protocol and apply colors to components

```
class CustomTableViewCell: UITableViewCell, AppPearCustomColorSchemeAwareView {
    @IBOutlet weak var customLabel: UILabel!

    func applyCustomColorScheme(_ colorScheme: AppPearCustomColorScheme) {
        backgroundColor = colorScheme[CustomTableCellColors.cellBackground]
        customLabel.textColor = colorScheme[CustomTableCellColors.cellTextColor]
    }
}
```

## Custom Fonts support

1. Introduce custom fonts you need

```
enum CustomFonts: String, AppPearanceKey {
    case textFont
    case subtextFont
    case titleFont
}
```

2. Prepare fonts schemes with structs conforming `AppPearCustomFonts` protocol

```
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
```

3. Describe font scheme names in enum

```
enum FontSizes: String, AppPearanceKey {
    case normal
    case large
}
```

4. Register font schemes and select actual fonts

```
AppPear.shared.register(fonts: normalFonts(), for: FontSizes.normal)
AppPear.shared.register(fonts: largeFonts(), for: FontSizes.large)
AppPear.shared.switchFontSize(to: FontSizes.normal)

```

5. Add support for custom fonts to custom components conforming `AppPearCustomFontsAwareView` protocol

```
class CustomTableViewCell: UITableViewCell, AppPearCustomFontsAwareView  {
    @IBOutlet weak var customLabel: UILabel!

    func applyCustomFonts(_ fontSize: AppPearCustomFonts) {
        customLabel.font = fontSize[CustomFonts.textFont]
    }
    
}
```

6. That's it. Now you can switch betwen font schemes

```
AppPear.shared.switchFontSize(to: FontSizes.large)
```

## Plans for next releases

1. Add support for more UIKit components.

2. Add support for font schemes in UIKit components.


