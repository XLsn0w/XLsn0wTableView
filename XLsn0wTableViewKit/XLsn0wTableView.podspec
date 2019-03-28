
Pod::Spec.new do |s|

  s.version      = "1.0.1"

  s.name         = "XLsn0wTableView"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wTableView"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wTableView.git", :tag => s.version.to_s }

  s.summary      = "XLsn0w性能优化版TableView, 减轻ViewController负担, 异步渲染内容到图片, 按照滑动速度按需加载内容, 重写处理网络图片加载。XLsn0wTableView代理<UITableViewDelegate, UITableViewDataSource>协议 cell按需加载 异步绘制 图片缓存  cell高度自适应缓存"

  s.author       = { "XLsn0w" => "xlsn0wios@gmail.com" }
  s.license      = 'MIT'
  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.source_files = "XLsn0wTableViewKit/**/*.{h,m}"

  s.dependency "Masonry"
  s.dependency "XLsn0wKit_objc"
  s.dependency "YYText"
  s.dependency "YYModel"
  s.dependency "MJRefresh"
  s.dependency "KVOController"
  s.dependency "UITableView+FDTemplateLayoutCell"

end
