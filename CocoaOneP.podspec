#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "CocoaOneP"
  s.version          = "0.1.0"
  s.summary          = "A short description of CocoaOneP."
  s.description      = <<-DESC
                       An optional longer description of CocoaOneP

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://exosite.com/platform/data-platform/"
  s.license          = 'MIT'
  s.author           = { "Michael Conrad Tadpol Tilstra" => "miketilstra@exosite.com" }
  s.source           = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/exosite'

  # s.platform     = :ios, '5.0'
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
  s.dependency 'AFNetworking', '~> 2.0'
end
