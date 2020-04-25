
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

  s.ios.deployment_target = '9.0'

  s.source_files = 'AJKit/Classes/**/*.{h,m}'
  s.prefix_header_file = 'AJKit/Classes/AJKit.pch'
  s.resource_bundles = {
      'AJKit' => ['AJKit/Assets/Image.xcassets']
  }
  s.dependency 'SVProgressHUD', '2.2.5'
  s.dependency 'MJRefresh', '3.2.3'
  s.dependency 'ReactiveObjC', '3.1.1'
  
end
