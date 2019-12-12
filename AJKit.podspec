
Pod::Spec.new do |s|
  s.name             = 'AJKit'
  s.version          = '0.4.0'
  s.summary          = 'A short description of AJKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xujiebing/AJKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xujiebing' => 'xujiebing1992@gmail.com' }
  s.source           = { :git => 'https://github.com/xujiebing/AJKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.default_subspec = 'Foundation'

  s.subspec 'Foundation' do |foundation|
    foundation.prefix_header_file = 'AJKit/Classes/Foundation/AJFoundation.pch'
    foundation.source_files = 'AJKit/Classes/Foundation/*.{h,m}'
  end
  
  s.subspec 'UIKit' do |kit|
    kit.prefix_header_file = 'AJKit/Classes/UIKit/AJUIKit.pch'
    kit.source_files = 'AJKit/Classes/UIKit/*.{h,m}'
    kit.dependency 'AJKit/Foundation'
  end
  
  s.subspec 'Runtime' do |runtime|
    runtime.prefix_header_file = 'AJKit/Classes/Runtime/AJRuntime.pch'
    runtime.source_files = 'AJKit/Classes/Runtime/*.{h,m}'
    runtime.dependency 'AJKit/Foundation'
  end
  
  s.subspec 'Algorithm' do |algorithm|
    algorithm.prefix_header_file = 'AJKit/Classes/Algorithm/AJAlgorithm.pch'
    algorithm.source_files = 'AJKit/Classes/Algorithm/**/*.{h,m}'
    algorithm.dependency 'AJKit/Foundation'
  end
  
  s.subspec 'APPKit' do |appkit|
    appkit.prefix_header_file = 'AJKit/Classes/APPKit/AJAPPKit.pch'
    appkit.source_files = 'AJKit/Classes/APPKit/**/*.{h,m}'
    appkit.resource = 'AJKit/Assets/AJAPPKit.bundle'
    appkit.dependency 'AJKit/Foundation'
    appkit.dependency 'SVProgressHUD', '2.2.5'
    appkit.dependency 'MJRefresh', '3.2.3'
  end
  
end
