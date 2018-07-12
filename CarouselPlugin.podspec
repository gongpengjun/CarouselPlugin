
Pod::Spec.new do |s|

  s.name         = "CarouselPlugin"
  s.version      = "0.0.1"
  s.summary      = "视图轮播插件滚动视图 提供向上向下向左向右 滚动"
  s.description  = <<-DESC
          UIView 自定义
            轮播滚动视图 提供向上向下向左向右 滚动
                   DESC

  s.homepage     = "https://github.com/weskhen/CarouselPlugin"

  s.license      = "MIT"

  s.author             = { "吴健" => "wujian516411567@.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/weskhen/CarouselPlugin.git", :tag => "#{s.version}" }

  s.source_files  = "Public/CarouselPlugin/*.{h,m}"

  s.requires_arc = true
  s.dependency "BBWeakTimer", "~> 1.0.1"

end
