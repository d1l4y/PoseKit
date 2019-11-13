Pod::Spec.new do |s|
  s.name = 'PoseKit'
  s.version = '0.3.0'
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = 'ARKit3 and RealityKit library for Body Position Tracking'
  s.homepage = 'https://github.com/d1l4y/poseKit'
  s.social_media_url = ''
  s.authors = { "Vinicius Dilay, Isabela Castro, Leonardo Palinkas, Lucas Ronnau, Saulo da Silva" => "email aqui" }
  s.source = { :git => "https://github.com/d1l4y/poseKit.git", :tag  => "v"+s.version.to_s }
  s.platforms = { :ios => "13.0"}
  s.requires_arc = true
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'

  s.default_subspec = "Core"
  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/**/*.swift"
    ss.framework  = "Foundation"
    ss.framework = "ARKit"
    ss.framework = "RealityKit"
 end


end
