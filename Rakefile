# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.version = File.exist?('VERSION') ? File.read('VERSION').chomp : ""
  gem.name = "jqgrid"
  gem.homepage = "http://github.com/optimis/jqgrid"
  gem.license = "MIT"
  gem.summary = "make 2dc_jqgrid a gem"
  gem.description = "make 2dc_jqgrid a gem"
  gem.email = "Kting@optimiscorp.com"
  gem.authors = ["Kung Dih Ting"]
  gem.files = Dir["{lib}/**/*", "{test}/*", ".document", "Gemfile", "LICENSE.txt", "README.rdoc", "Rakefile", "VERSION"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION').chomp : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "jqgrid #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
