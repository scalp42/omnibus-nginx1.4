# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omnibus-software/version"

Gem::Specification.new do |s|
  s.name        = "omnibus-nginx"
  s.version     = OmnibusSoftware::VERSION
  s.authors     = ["Myroslav Rys"]
  s.email       = ["stonevil@gmail.com"]
  s.homepage    = "https://github.com/stonevil/"
  s.summary     = %q{Nginx 1.4.1 omnibus package with statsd cache-purge http-accounting sticky tcp-proxy modules}
  s.description = %q{Nginx 1.4.1 omnibus package with statsd cache-purge http-accounting sticky tcp-proxy modules}

  s.rubyforge_project = "omnibus-nginx"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end

# s3_access_key "something"
# s3_secret_key "something"
# s3_bucket "some-bucket"
# use_s3_caching true
# solaris_compiler "gcc"
