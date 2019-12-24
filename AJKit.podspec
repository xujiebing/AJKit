
Pod::Spec.new do |s|
  s.name             = 'AJKit'
  s.version          = '0.4.1'
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

  s.subspec 'Foundation' do |ss|
    ss.prefix_header_file = 'AJKit/Classes/Foundation/AJFoundation.pch'
    ss.source_files = 'AJKit/Classes/Foundation/*.{h,m}'
  end
  
  s.subspec 'UIKit' do |ss|
    ss.prefix_header_file = 'AJKit/Classes/UIKit/AJUIKit.pch'
    ss.source_files = 'AJKit/Classes/UIKit/*.{h,m}'
    ss.dependency 'AJKit/Foundation'
  end
  
  s.subspec 'Runtime' do |ss|
    ss.prefix_header_file = 'AJKit/Classes/Runtime/AJRuntime.pch'
    ss.source_files = 'AJKit/Classes/Runtime/*.{h,m}'
    ss.dependency 'AJKit/Foundation'
  end
  
  s.subspec 'Algorithm' do |ss|
    ss.prefix_header_file = 'AJKit/Classes/Algorithm/AJAlgorithm.pch'
    ss.source_files = 'AJKit/Classes/Algorithm/**/*.{h,m}'
    ss.dependency 'AJKit/Foundation'
  end
  
  s.subspec 'APPKit' do |ss|
    ss.prefix_header_file = 'AJKit/Classes/APPKit/AJAPPKit.pch'
    ss.source_files = 'AJKit/Classes/APPKit/**/*.{h,m}'
    ss.resource = 'AJKit/Assets/AJAPPKit.bundle'
    ss.dependency 'AJKit/Foundation'
    ss.dependency 'AJKit/UIKit'
    ss.dependency 'SVProgressHUD', '2.2.5'
    ss.dependency 'MJRefresh', '3.2.3'
    ss.dependency 'ReactiveObjC', '3.1.1'
    
  end
  
end
