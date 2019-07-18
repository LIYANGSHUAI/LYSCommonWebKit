Pod::Spec.new do |s|

  s.name         = "LYSCommonWebKit"
  s.version      = "0.0.1"
  s.summary      = "解决开发中,H5与原生混合过程中,js和原生交互繁琐,逻辑复杂,频繁交换数据的问题"
  s.description  = <<-DESC
解决开发中,H5与原生混合过程中,js和原生交互繁琐,逻辑复杂,频繁交换数据的问题
解决开发中,H5与原生混合过程中,js和原生交互繁琐,逻辑复杂,频繁交换数据的问题
                   DESC
  s.homepage     = "https://github.com/LIYANGSHUAI/LYSCommonWebKit"
s.platform       = :ios
  s.license      = "MIT"
  s.author             = { "LIYANGSHUAI" => "liyangshuai163@163.com" }
  s.source       = { :git => "https://github.com/LIYANGSHUAI/LYSCommonWebKit.git", :tag => s.version }
  s.source_files  = "LYSCommonWebKit/*.{h,m}"
end
