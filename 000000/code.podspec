
@version = "1.0.0"

Pod::Spec.new do |s|
s.name = "code"
s.version = @version
s.summary = "为UIImageView加圆角"
s.description = "为UIImageView加圆角12233444"
s.homepage = "https://github.com/NewQuine/demo1"
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.author = { "Newquine" => "newquine@126.com" }
s.ios.deployment_target = '8.0'
s.source = { :git => "https://github.com/NewQuine/demo1.git", :tag => "v#{s.version}" }
s.source_files = 'demo1/000000/code/*.{h,m}'
s.requires_arc = true
s.framework = "UIKit"
end
