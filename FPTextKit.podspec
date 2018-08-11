#
# Be sure to run `pod lib lint FPTextKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FPTextKit'
  s.version          = '1.0.0'
  s.summary          = 'Input text of FPTextKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: A Input text of FPTextKit.
      Support TextFiled TextView
                       DESC

  s.homepage         = 'https://github.com/fakepinge/FPTextKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fakepinge@gmail.com' => 'fakepinge@gmail.com' }
  s.source           = { :git => 'https://github.com/fakepinge/FPTextKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'FPTextKit/Classes/**/*'

  # s.resource_bundles = {
  #   'FPTextKit' => ['FPTextKit/Assets/*.png']
  # }

end
