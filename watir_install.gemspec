# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "watir_install"
  spec.version       = "0.4.0.beta8"
  spec.authors       = ["Titus Fortner"]
  spec.email         = ["titusfortner@gmail.com"]

  spec.summary       = %q{UI Test Automation Framework}
  spec.description   = %q{"Watir Install provides everything necessary to quickly create maintainable automated test suites in an understandable and enjoyable way."}
  spec.homepage      = "https://github.com/titusfortner/watir_install"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ['watir']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency "require_all"
  spec.add_dependency 'data_magic'
  spec.add_dependency 'activesupport', '~> 4.0', '>= 4.1.11'
  spec.add_dependency "git", "~> 1.3"
end
