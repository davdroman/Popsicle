Pod::Spec.new do |s|
  s.name                  = "Popsicle"
  s.version               = "3.0.0-beta.1"
  s.summary               = "Simple, extensible interpolation framework"
  s.homepage              = "https://github.com/DavdRoman/Popsicle"
  s.author                = { "David Román" => "d@vidroman.me" }
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.social_media_url      = 'https://twitter.com/DavdRoman'

  s.platform              = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source                = { :git => "https://github.com/DavdRoman/Popsicle.git", :tag => s.version.to_s }
  s.source_files          = 'Popsicle/*.{h,swift}'
  s.frameworks            = 'UIKit'
  s.requires_arc          = true
end
