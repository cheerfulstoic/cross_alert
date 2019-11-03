
require 'erb'

terms = %w[
  brand
  drunknat
  bomba
  skytten
  polis
  snökaos
  storm
  översvämning
  skjutning
]

template_string = File.read("js/config.js.erb")
File.open('js/config.js', 'w') {|f| f << ERB.new(template_string).result(binding) }

template_string = File.read("index.html.erb")
File.open('index.html', 'w') {|f| f << ERB.new(template_string).result(binding) }
