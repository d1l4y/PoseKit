Pod::Spec.new do |s|
  s.name = 'poseKit'
  s.version = '0.0.5'
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = 'sumario aqui'
  s.homepage = 'homepage aqui'
  s.social_media_url = 'https://twitter.com/twitter aqui'
  s.authors = { "Vinicius Dilay, Isabela Castro, Leonardo Palinkas, Lucas Ronnau, Saulo da Silva" => "email aqui" }
  s.source = { :git => "https://github.com/d1l4y/poseKit.git", :tag  => "v"+s.version.to_s }
  s.platforms = { :ios => "9.0", :osx => "10.10", :tvos => "9.0", :watchos => "2.0" }
  s.requires_arc = true
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'

  s.default_subspec = "Core"
  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/**/*.swift"
    ss.framework  = "Foundation"
 end
end
