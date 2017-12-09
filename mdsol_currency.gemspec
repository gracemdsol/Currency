require File.expand_path('../lib/mdsol_currency/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "mdsol_currency"
  s.version = MdsolCurrency::VERSION
  s.summary = "Mdsol Currency"
  s.description = ""
  s.authors = ["Grace Zhou"]
  s.email = "yazhou@mdsol.com"
  s.homepage = "https://github.com/gracemdsol/mdsol_currency"
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('activerecord')
  s.add_dependency('activemodel')
  s.add_dependency('activesupport')

  # Need these gems to test client integration with rails
  s.add_development_dependency('rails', '~> 4.2.8')
  s.add_development_dependency('rspec', '~> 3.0')
  s.add_development_dependency('database_cleaner', '1.0.1')
  s.add_development_dependency('byebug', '~> 4.0')
end
