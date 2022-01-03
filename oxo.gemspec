require_relative "lib/oxo/version"

version  = OXO::VERSION
date     = OXO::DATE
homepage = OXO::HOMEPAGE

Gem::Specification.new do |s|
  s.name              = "oxo"
  s.version           = version
  s.date              = date

  s.summary = "oxo is a command line Tic-tac-toe game."
  s.description = s.summary

  s.authors = ["Marcus Stollsteimer"]
  s.email = "sto.mar@web.de"
  s.homepage = homepage

  s.license = "GPL-3.0"

  s.required_ruby_version = ">= 2.0.0"

  s.add_development_dependency "minitest", "~> 5.8"
  s.add_development_dependency "rake", "~> 13.0"

  s.executables = ["oxo"]
  s.bindir = "bin"

  s.require_paths = ["lib"]

  s.files = %w[
      oxo.gemspec
      README.md
      Rakefile
    ] +
    Dir.glob("{bin,lib,test}/**/*")

  s.extra_rdoc_files = %w[README.md]
  s.rdoc_options = ["--charset=UTF-8", "--main=README.md"]
end
