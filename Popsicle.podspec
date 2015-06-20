Pod::Spec.new do |s|
  s.name                  = "Popsicle"
  s.version               = "1.1.2"
  s.summary               = "Simple, extensible value interpolation framework"
  s.homepage              = "https://github.com/DavdRoman/Popsicle"
  s.author                = { "David Roman" => "d@vidroman.me" }
  s.license               = { :type => 'MIT', :file => 'LICENSE' }

  s.platform              = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source                = { :git => "https://github.com/DavdRoman/Popsicle.git", :tag => s.version.to_s }
  s.source_files          = 'Popsicle/*.{h,m}'
  s.frameworks            = 'Foundation', 'UIKit'
  s.requires_arc          = true
end
