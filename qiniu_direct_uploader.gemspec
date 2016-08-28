# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qiniu_direct_uploader/version'

Gem::Specification.new do |s|
  s.name          = "qiniu_direct_uploader"
  s.version       = QiniuDirectUploader::VERSION
  s.authors       = ["Marble Wu"]
  s.email         = ["huobazi@gmail.com"]
  s.description   = %q{Direct upload to a Qiniu storage bucket.}
  s.summary       = %q{Direct upload to a Qiniu storage bucket.}
  s.homepage      = "https://github.com/huobazi/qiniu_direct_uploader"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '>= 3.2'
  s.add_dependency 'coffee-rails', '>= 3.2.1'
  s.add_dependency 'sass-rails', '>= 3.2.5'

  s.add_dependency 'qiniu', '6.6.0'

  s.add_dependency "jquery-fileupload-rails", "~> 0.4.1"

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end
