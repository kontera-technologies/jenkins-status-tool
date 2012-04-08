require 'rubygems/package_task'

JenkinsStatusTool::GemSpec = Gem::Specification.new do |s|
  s.name                  = "jenkins-status-tool"
  s.version               = JenkinsStatusTool.version
  s.platform              = Gem::Platform::RUBY
  s.summary               = "A Small web-service that fetch project status from Jenkins/Hudson"
  s.description           = "Small tool to get the build status from Jenkins. Useful for embedding Jenkins CI status images on your Github project."
  s.author                = "Eran Barak Levi"
  s.email                 = 'eran@kontera.com'
  s.homepage              = 'http://www.kontera.com'
  s.executables           = %w(jenkins-status-tool)
  s.required_ruby_version = '>= 1.8.7'
  s.rubyforge_project     = "jenkins-status-tool"
  s.files                 = %w(README.markdown Rakefile) + Dir.glob("{bin,lib,test,tasks,public,views}/**/*")
  s.require_path          = "lib"
  s.bindir                = "bin"

  s.add_dependency 'sinatra'
  s.add_dependency 'json'
end

task :gem => [:clobber_package]
Gem::PackageTask.new(JenkinsStatusTool::GemSpec) do |p|
  p.gem_spec = JenkinsStatusTool::GemSpec
end

task :install => [:gem] do
   sh "gem install pkg/jenkins-status-tool"
   Rake::Task['clobber_package'].execute
end

namespace :gem do
  desc "Upload jenkins-status-tool to Kontera's repo"
  task :upload => [:build] do
    sh "gem inabox --host http://gems.kontera.com pkg/jenkins-status-tool-#{JenkinsStatusTool.version}.gem"
  end
  
  desc "Update GraphiteAPI gem version and build gem"
  task :build => [:test] do
    sh "rake gem"
  end 
  
end