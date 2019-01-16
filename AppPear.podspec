Pod::Spec.new do |s|
  s.name         = "AppPear"
  s.version      = "1.0.0"
  s.summary      = "Swift library for custom application appearance and dynamic color themes and fonts switching"
  s.homepage     = "https://github.com/sionyx/AppPear"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "SiONYX" => "sionyx.ru+apppear@gmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/sionyx/AppPear.git", :tag => s.version }
  s.source_files  = "AppPear/*.swift", "AppPear/ColorScheme/*.swift", "AppPear/Fonts/*.swift"
  s.requires_arc = true
end
