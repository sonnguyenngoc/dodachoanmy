$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "erp/hoanmy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "erp_hoanmy"
  s.version     = Erp::Hoanmy::VERSION
  s.authors     = ["Nguyễn Ngọc Sơn"]
  s.email       = ["sonnn0811@gmail.com"]
  s.homepage    = "http://dodachoanmy.vn/"
  s.summary     = "Website đo đạc Hoàn Mỹ"
  s.description = "Website đo đạc Hoàn Mỹ"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.1.6.1"
  s.add_dependency "erp_core"
  s.add_dependency "deface"
end
