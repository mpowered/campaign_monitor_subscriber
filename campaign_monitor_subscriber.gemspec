# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "campaign_monitor_subscriber"
  s.version     = '0.6.4'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Gary Greyling"]
  s.email       = ["gary@mpowered.co.za"]
  s.homepage    = "https://github.com/mpowered/campaign_monitor_subscriber"
  s.summary     = %q{Sync user emails with Campaign Monitor mailing lists}
  s.description = %q{Sync user emails with Campaign Monitor mailing lists}

  s.files         = `git ls-files -- {lib/*,vendor/*,*.gemspec}`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rails', '>= 3.0.0'
  s.add_development_dependency 'campaigning', '>= 0.15.0'

  ruby_minor_version = RUBY_VERSION.split('.')[1].to_i
end