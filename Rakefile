require "rake/testtask"


def gemspec_file
  "oxo.gemspec"
end


task default: [:test]

Rake::TestTask.new do |t|
  t.pattern = "test/**/test_*.rb"
  t.verbose = true
  t.warning = true
end


desc "Build gem"
task :build do
  sh "gem build #{gemspec_file}"
end


desc "Remove generated files"
task :clean do
  FileUtils.rm(Dir.glob("*.gem"))
end
