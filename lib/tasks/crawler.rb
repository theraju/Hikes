require 'rubygems'
require 'anemone'

Anemone.crawl("http://www.wta.org/go-hiking/hikes") do |anemone|
    anemone.on_every_page { |page| puts page.doc.at('title').inner_html rescue nil }
    anemone.focus_crawl { |page| page.links.find_all{|link| link.to_s.scan(%r|(http://www.wta.org/go-hiking/hikes/[a-zA-Z0-9]+)|).length > 0 } }
end
