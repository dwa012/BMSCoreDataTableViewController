#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "BMSCoreDataTableViewController"
  s.version          = "0.1.2"
  s.summary          = "A subclass of UITableViewController that abstracts the Core Data elements"
  s.description      = "See Readme"
  s.homepage         = "https://github.com/dwa012/BMSCoreDataTableViewController"
  #s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache v2.0'
  s.author           = { "Daniel Ward" => "dwa012@gmail.com" }
  s.source           = { :git => "https://github.com/dwa012/BMSCoreDataTableViewController.git", :tag => s.version.to_s }
  #s.social_media_url = 'https://twitter.com/EXAMPLE'

  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets/*.png'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
end
