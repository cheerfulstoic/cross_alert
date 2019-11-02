
require 'erb'

template_string = File.read("js/config.js.erb")
File.open('js/config.js', 'w') {|f| f << ERB.new(template_string).result(binding) }

template_string = File.read("tweets.html.erb")
File.open('tweets.html', 'w') {|f| f << ERB.new(template_string).result(binding) }
