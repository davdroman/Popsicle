Pod::Spec.new do |s|
  s.name         = "DRDynamicSlideShow"
  s.version      = "1.0.1"
  s.summary      = "A UIScrollView subclass to easily implement an amazing swiping interactive slide show, as IFTTT's."
  s.homepage     = "https://github.com/Dromaguirre/DRDynamicSlideShow"
  s.screenshots  = "https://raw.githubusercontent.com/Dromaguirre/DRDynamicSlideShow/images/1.gif"
  s.license      = 'MIT'
  s.author       = { "David Román" => "dromaguirre@gmail.com" }
  s.source       = { :git => "https://github.com/Dromaguirre/DRDynamicSlideShow.git", :tag => "#{s.version}" }
  s.source_files = 'Source/*.{h,m}'
  s.requires_arc = true
  s.platform     = :ios, '7.0'
end
