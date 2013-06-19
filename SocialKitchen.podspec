Pod::Spec.new do |s|
  s.name         = "SocialKitchen"
  s.version      = "0.0.1"
  s.summary      = "Kitchen sink that demostartes OAuth flow for service providers(weibo, tcwb)."
  s.homepage     = "https://github.com/RobinQu/RSocialKitchen"
  
  s.license = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "RobinQu" => "robinqu@gmail.com" }

  s.source       = { :git => "https://github.com/RobinQu/RSocialKitchen.git", :tag => "0.0.2" }

  s.platform     = :ios, '5.0'

  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.frameworks = 'CoreGraphics', 'UIKit', 'Foundation'

  s.requires_arc = true

  s.dependency 'JSONKit', '1.5pre'
  s.dependency 'JSONKit', '1.5pre'
  s.dependency "SVProgressHUD", "0.9"
end