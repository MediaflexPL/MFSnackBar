#
# Be sure to run `pod lib lint MFSnackBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MFSnackBar'
  s.version          = '0.1.1'
  s.summary          = 'Small notifications loosely based on iOS banner notifications and Android\'s snackbar'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Display notifications with accessories, buttons, different actions for dismiss and button touch. All that with a smooth and stylish animation!
                       DESC

  s.homepage         = 'https://github.com/MediaflexPL/MFSnackBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jakub Darowski' => 'jakub.darowski@mediaflex.pl' }
  s.source           = { :git => 'https://github.com/MediaflexPL/MFSnackBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.module_name = 'MFSnackBar'
  s.ios.deployment_target = '9.0'

  s.source_files = 'MFSnackBar/Classes/*.swift'
  
  s.resources = ['MFSnackBar/Assets/*.xib', 'MFSnackBar/Assets/*.png']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'SteviaLayout', '~> 3.0'
end
