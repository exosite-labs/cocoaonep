Pod::Spec.new do |s|
  s.name             = "CocoaOneP"
  s.version          = "1.0.0"
  s.summary          = "Cocoa library for using the Exosite One Platform."
  s.homepage         = "http://docs.exosite.com/"
  s.license          = 'BSD'
  s.author           = { "Michael Conrad Tadpol Tilstra" => "miketilstra@exosite.com" }
  s.source           = { :git => "https://github.com/exosite-labs/cocoaonep.git",
                         :tag => "v#{s.version}" }
  s.social_media_url = 'https://twitter.com/exosite'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.dependency 'AFNetworking', '2.6.3'

  s.subspec 'All' do |ss|
    ss.dependency 'CocoaOneP/RPC'
    ss.dependency 'CocoaOneP/WebSocket'
  end

  s.subspec 'RPC' do |ss|
    ss.source_files = 'Classes/rpc'
  end

  s.subspec 'WebSocket' do |ss|
    ss.dependency 'CocoaOneP/RPC'
    ss.dependency 'SocketRocket', '0.4.1'
    ss.source_files = 'Classes/ws'
  end

end


# vim: set sw=2 ts=2 et ft=ruby :
