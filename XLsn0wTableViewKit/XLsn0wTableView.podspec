
Pod::Spec.new do |s|

  s.version      = "1.0.2"

  s.name         = "XLsn0wTableView"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wTableView"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wTableView.git", :tag => s.version.to_s }

  s.summary      = "XLsn0w性能优化版TableView, 异步渲染, 按需加载, 高度自适应缓存"

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

# xlsn0w$ git tag 1.0.0
# xlsn0w$ git push origin --tags
# xlsn0w$ pod spec lint XLsn0wTableView.podspec --allow-warnings
# xlsn0w$ pod trunk push XLsn0wTableView.podspec --allow-warnings
