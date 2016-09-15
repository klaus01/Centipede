Pod::Spec.new do |s|
  s.name         = "Centipede"
  s.version      = "2.0.0"
  s.summary      = "Swift achieve a pure library closures achieve UIKit assembly delegate and dataSource methods."
  s.description  = <<-DESC
一个 Swift 库，使用闭包实现 UIKit 等组件的 delegate 和 dataSource 方法

解决什么问题

在实现 delegate 的各个方法时：

方法遍布整个 ViewController，散乱。
具体的实现与成员变量被分开了，阅读时需要分开查看。
如果 ViewController 中实现多个 UITableViewDataSource 时，方法中需要判断组件来做出反应。如下：（这很丑）
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableView == leftTableView ? leftDatas.count : rightDatas.count
}
这些情况让代码不易阅读和维护。

希望：

代码连续。组件的构造、样式设置和各 delegate 实现方法可写在一个位置。
独立。有多个 UITableView 时，tableViewA 和tableViewB 的 delegate 方法实现是独立的，互不干扰。
                   DESC
  s.homepage            = "https://github.com/klaus01/Centipede"
  s.license             = { :type => "MIT", :file => "LICENSE" }
  s.author              = { "柯磊" => "kelei0017@gmail.com" }
  s.social_media_url    = "http://twitter.com/kelei0017"
  s.platform            = :ios, "8.0"
  s.source              = { :git => "https://github.com/klaus01/Centipede.git", :tag => "#{s.version}" }
  s.source_files        = "Centipede/**/*.swift", "Centipede/Centipede.h"
  s.public_header_files = "Centipede/Centipede.h"
  s.requires_arc        = true
end
