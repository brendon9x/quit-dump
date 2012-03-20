Gem::Specification.new do |s|
  s.name = 'quit-dump'
  s.version = '0.5'
  s.summary = "Install INT signal thread dumper"
  s.files = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.has_rdoc = false
  s.author = "Brendon McLean"
  s.email = "brendon@twistedprotein.com"
  s.homepage = "https://github.com/brendon9x/quit-dump"

  require 'quit-dump'
end