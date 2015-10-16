Pod::Spec.new do |s|
  s.name = 'PopStatusItem'
  s.version = '0.4.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Status bar item with NSPopover'
  s.homepage = 'https://github.com/adamhartford/PopStatusItem'
  s.social_media_url = 'http://twitter.com/adamhartford'
  s.authors = { 'Adam Hartford' => 'adam@adamhartford.com' }
  s.source = { :git => 'https://github.com/adamhartford/PopStatusItem.git', :tag => "v#{s.version}" }

  s.osx.deployment_target = '10.10'

  s.source_files = 'PopStatusItem/*.swift'

  s.requires_arc = true
end
