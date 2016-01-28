Pod::Spec.new do |s|
  s.name         = "Centipede"
  s.version      = "1.1.0"
  s.summary      = "Swift achieve a pure library closures achieve UIKit assembly delegate and dataSource methods."
  s.description  = <<-DESC
                   一个Swift库，使用闭包实现UIKit组件的delegate和dataSource方法。
                   DESC
  s.homepage            = "https://github.com/klaus01/Centipede"
  s.license             = { :type => "MIT", :file => "LICENSE" }
  s.author              = { "柯磊" => "kelei0017@gmail.com" }
  s.social_media_url    = "http://twitter.com/kelei0017"
  s.platform            = :ios, "8.0"
  s.source              = { :git => "https://github.com/klaus01/Centipede.git", :tag => s.version }
  s.source_files        = "Centipede/**/*.swift", "Centipede/Centipede.h"
  s.public_header_files = "Centipede/Centipede.h"
  s.requires_arc        = true
end
