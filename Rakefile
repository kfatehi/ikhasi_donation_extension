require 'rubygems'
require 'bundler'
Bundler.setup
require 'rake'
require 'coffee-script'
require 'fileutils'

KANGO_FRAMEWORK_URL = "http://kangoextensions.com/kango/kango-framework-latest.zip"
KANGO_FRAMEWORK = "kango-framework"

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

def framework_exists?
  File.directory? KANGO_FRAMEWORK
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
  if framework_exists?
    `python ./kango-framework/kango.py build .`
  else
    puts "Kango Framework is missing. Install it with 'rake kango:install"
  end
end

namespace :kango do
  desc 'Install the kango framework'
  task :install do
    zipfile = "#{KANGO_FRAMEWORK}.zip"
    puts "Downloading Kango Framework to #{zipfile}..."
    require 'open-uri'
    File.open(zipfile, 'wb') do |file|
      open(KANGO_FRAMEWORK_URL, 'rb') do |download|
        file.write download.read
      end
    end
    puts "Download complete! Extracting..."
    `unzip #{zipfile} -d #{KANGO_FRAMEWORK}`
    if framework_exists?
      FileUtils.rm zipfile
      puts "Kango Framework is ready. You can now rake build"
    else
      puts "Something went wrong... probably could not download Kango Framework"
    end
  end
end
