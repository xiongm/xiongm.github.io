# encoding: UTF-8
require 'iconv'
require 'cgi'

Dir.glob('*.html').each do|f|

  basename = File.basename(f, ".html")
  output_file = "convert/#{basename}.md"

  content = File.read("#{basename}.html").
	    encode('UTF-8', :invalid => :replace, :undef => :replace).
            # following 2 are some kind of utf8 conversion
	    gsub(/[^\x00-\x7F]/,' ').
            gsub(/\[\/*caption[^\]]*\]/,'').
            # remove all html tags
            gsub(/<\/?[^>]*>/,"").
            gsub(/\[code language=\"cpp\"\]/, "{% highlight cpp %}").
            gsub(/\[\/code\]/, "{% endhighlight %}")


  File.open(output_file,'w') do |f|
    # unescape string that has been HTML-escaped
    # e.g. vector&lt;MyObject&gt; => vector<MyObject>
    # this provides more comprehensive conversion than
    # individual gsubs
    f.write CGI.unescapeHTML(content)
  end
end
