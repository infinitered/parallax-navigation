# -*- encoding: utf-8 -*-
VERSION = "1.0"

Gem::Specification.new do |spec|
  spec.name          = "parallax-navigation"
  spec.version       = VERSION
  spec.authors       = ["Gant"]
  spec.email         = ["GantMan@gmail.com"]
  spec.description   = "RubyMotion Parallax Navigation"
  spec.summary       = "We want you to easily and naturally implement awe inspiring transitions in your app. With code similar to what you're comfortable with in UINavigationView, we've wrapped parallax navigation in a small gem."
  spec.homepage      = "https://github.com/infinitered/parallax-navigation"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby_motion_query"
  spec.add_development_dependency "rake"
end
