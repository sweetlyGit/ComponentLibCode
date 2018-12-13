#
# Be sure to run `pod lib lint ComponentLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'ComponentLib'
  s.version          = '1.0.0'
  s.summary          = '公用组件测试'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

  s.homepage         = 'https://github.com/sweetlyGit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sweetlyGit' => '2235861673@qq.com' }
  s.source           = { :git => 'https://github.com/sweetlyGit/ComponentLibCode.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ComponentLib/Classes/**/*'
  
#   s.resource_bundles = {
#  'ComponentLib' => ['ComponentLib/Assets/*.png']
# }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking', '~> 3.2.1'
    s.dependency 'AFNetworking', '~> 3.2.1'
    s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
    s.dependency 'Reachability', '~> 3.2'
    s.dependency 'ActionSheetPicker-3.0', '~> 2.3.0'
    s.dependency 'Toast', '~> 4.0.0'
    s.dependency 'MBProgressHUD', '~> 1.1.0'
    s.dependency 'BANetManager', '~> 2.3.10'
    s.dependency 'MJRefresh', '~> 3.1.15.3'
    s.dependency 'SDWebImage', '~> 4.4.0'
    s.dependency 'Masonry', '~> 1.1.0'
    s.dependency 'WechatOpenSDK', '~> 1.8.3'
end
