Pod::Spec.new do |s|
  s.name         = "Centipede"
  s.version      = "2.0.0"
  s.summary      = "Swift achieve a pure library closures achieve UIKit assembly delegate and dataSource methods."
  s.description  = <<-DESC
一个Swift库，使用闭包实现UIKit组件的delegate和dataSource方法

解决什么问题

在实现delegate的各个方法时：

方法遍布整个ViewController，很散。
具体的实现与成员变量被分开了，阅读时需要分开查看。
如果当对象中实现多个UITableViewDataSource时，方法中需要判断组件来做出反应。如：（这很丑）
@objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableView == leftTableView ? leftDatas.count : rightDatas.count
}
这些情况让代码不易阅读和维护。

希望：

代码连续。组件的构造、样式设置和各delegate实现方法可写在一个位置。
独立。有多个UITableView时，tableViewA和tableViewB的delegate方法实现是独立的，互不干扰。
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
