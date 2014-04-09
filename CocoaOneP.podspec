Pod::Spec.new do |s|
  s.name             = "CocoaOneP"
  s.version          = "0.3.2"
  s.summary          = "Cocoa library for using the Exosite One Platform."
  s.description      = <<-DESC
                       # Cocoa library for using the Exosite One Platform.
                       DESC
  s.homepage         = "http://exosite.com/platform/data-platform/"
  s.license          = 'BSD'
  s.author           = { "Michael Conrad Tadpol Tilstra" => "miketilstra@exosite.com" }
  s.source           = { :git => "ssh://git@i.exosite.com:miketilstra/cocoaonep.git",
                         :tag => "v#{s.version}" }
  s.social_media_url = 'https://twitter.com/exosite'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'
  s.requires_arc = true

  # s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.dependency 'AFNetworking', '~> 2.2'

  s.subspec 'All' do |ss|
    ss.dependency 'CocoaOneP/HTTP'
    ss.dependency 'CocoaOneP/RPC'
    ss.dependency 'CocoaOneP/Portal'
  end

  s.subspec 'HTTP' do |ss|
    ss.source_files = 'Classes/http'
  end

  s.subspec 'RPC' do |ss|
    ss.source_files = 'Classes/rpc'
  end

  s.subspec 'Portal' do |ss|
    ss.source_files = 'Classes/portal'
  end
end


# vim: set sw=2 ts=2 et ft=ruby :
