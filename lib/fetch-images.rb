raw = File.new("./main.css").read

urls = raw.scan(/url\((.*?)\)/).collect {|r| r[0]}
base = "http://github.com"

p urls
#urls.each do |url|
#  path = url.split("/")[0..-2].join("/")
#  file = url.split("/")[-1]
#  mk = "mkdir -p /Users/jsomers/quizdash/public#{path}"
#  get = "/usr/local/bin/wget #{base + url} --no-check-certificate -O /Users/jsomers/quizdash/public#{url}"
#  %x[#{mk}]
#  %x[#{get}]
#end