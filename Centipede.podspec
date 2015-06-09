Pod::Spec.new do |s|

  s.name         = "Centipede"
  s.version      = "1.0"
  s.summary      = "一个纯Swift实现的库，使用闭包实现UIKit组件的delegate和dataSource方法。"

  s.description  = <<-DESC
                   Centipede 是一个纯Swift实现的库，使用闭包实现UIKit组件的delegate和dataSource方法。
                   DESC

  s.homepage     = "https://github.com/klaus01/Centipede"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "柯磊" => "kl0017@163.com" }
  s.social_media_url   = "http://weibo.com/klaus01"

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/klaus01/Centipede.git", :tag => s.version }
  s.source_files = "Centipede/*"
  s.requires_arc = true

  s.frameworks   = "UIKit"
end