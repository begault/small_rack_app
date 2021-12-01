begin
  require 'bundler/inline'
rescue LoadError => e
  $stderr.puts 'Bundler version 1.10 or later is required. Please update your Bundler'
  raise e
end

gemfile(true) do
  source 'https://rubygems.org'
  git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

  gem 'rack'
  gem 'webrick'
end

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

options = {
  Host: '0.0.0.0', # Important : Binding on all interface
  Port: '8080'
}

Rack::Handler::WEBrick.run(lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}, **options)
