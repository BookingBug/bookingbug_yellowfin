$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bookingbug_yellowfin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bookingbug_yellowfin"
  s.version     = BookingbugYellowfin::VERSION
  s.authors     = ["Joel Sturmfels"]
  s.email       = ["joel@bookingbug.com"]
  s.homepage    = "https://www.bookingbug.com"
  s.summary     = "Rails engine that creates and populates reporting tables for yellowfin BI."
  s.description = "Rails engine that creates and populates reporting tables for yellowfin BI."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.19"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
