Pod::Spec.new do |s|
  s.name         = "STShareTool"
  s.version      = "1.0.0"
  s.summary      = "The package of useful tools, include categories and classes"
  s.homepage     = "http://www.saitjr.com"
  s.license      = "MIT"
  s.authors      = { 'tangjr' => 'tangjr.work@gmail.com'}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/saitjr/STShareTool.git", :tag => s.version }
  s.source_files = 'STShareTool', 'STShareTool/**/*.{h,m}'
  s.requires_arc = true

  s.subspec "UMengSocialCOM" do |ss|
    s.source_files = 'UMengSocialCOM', 'UMengSocialCOM/**/*.{h,m,a}'
    ss.dependency "STShareTool/Core"
    ss.dependency "UMengSocialCOM", "~> 5.2"
  end

end