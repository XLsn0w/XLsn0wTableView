
Pod::Spec.new do |s|

  s.version      = "1.0.0"

  s.name         = "XLsn0wTableView"
  s.homepage     = "https://github.com/XLsn0w/XLsn0wTableView"
  s.source       = { :git => "https://github.com/XLsn0w/XLsn0wTableView.git", :tag => s.version.to_s }

  s.summary      = "XLsn0w Custom A Text Up Down Carousel Component"
  s.description  = "XLsn0w Custom A Text Up Down Carousel Component From XLsn0wKit"

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
