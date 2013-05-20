require 'rubygems'
require 'bundler'
Bundler.setup
require 'rake'
require 'coffee-script'
require 'fileutils'

KANGO_FRAMEWORK_ZIP = "http://kangoextensions.com/kango/kango-framework-latest.zip"

# Extract userscript comment block from CoffeeScript file.
def userscript_commentblock(coffee_file)
  comment = ""
  File.open(coffee_file) do |f|
    while line = f.gets
      break unless line =~ /^#/
      comment += line.gsub(/^#/, '//')
    end
  end
  comment
end

desc 'Compile coffeescript userscripts into common as javascript'
task :compile do
  Dir.glob('src/coffee/**/*.coffee') do |file|
    script = file.gsub(/(^coffee|coffee$)/, 'js').split('/').last
    path = Pathname.new('src/common').join(script)
    puts "[   INFO] Compiling #{file} to #{path.to_s}"
    FileUtils.mkdir_p path.dirname
    File.open(path.to_s, 'w') do |f|
      f.puts userscript_commentblock(file)
      f.puts CoffeeScript.compile File.read(file), :bare => true
    end
  end
end

desc 'Build the extensions with Kango'
task :build => :compile do
  if File.directory?('kango-framework')
    `python ./kango-framework/kango.py build .`
  else
    puts "Kango Framework is missing. Install it with 'rake kango:install"
  end
end

def download_kango_framework zipfile
  puts "Downloading Kango Framework to #{zipfile}..."
  require 'open-uri'
  File.open(zipfile, 'wb') do |file|
    open(KANGO_FRAMEWORK_ZIP, 'rb') do |download|
      file.write download.read
    end
  end
  puts "Download complete!"
  zipfile
end

def extract zipfile, target
  require 'zip/zipfilesystem'
  puts "Unzipping #{zipfile} to #{target}"
  
end

namespace :kango do
  desc 'Install the kango framework'
  task :install do
    zipfile = 'kango-framework.zip'  
    download_kango_framework(zipfile)
    
  end
end
