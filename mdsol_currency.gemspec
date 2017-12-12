require File.expand_path('../lib/mdsol_currency/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "mdsol_currency"
  s.version = MdsolCurrency::VERSION
  s.summary = "Mdsol Currency"
  s.description = "Provides currencies, countries, and exchange rates."
  s.authors = ["Grace Zhou"]
  s.email = "yazhou@mdsol.com"
  s.homepage = "https://github.com/gracemdsol/mdsol_currency"
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
