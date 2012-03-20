require 'base64'

Gem::Specification.new do |s|
  s.name = 'quit-dump'
  s.version = '0.6'
  s.summary = "Install INT signal thread dumper"
  s.files = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.has_rdoc = false
  s.author = "Brendon McLean"
  s.email = Base64.decode64("YnJlbmRvbkB0d2lzdGVkcHJvdGVpbi5jb20=\n")
  s.homepage = "https://github.com/brendon9x/quit-dump"
end