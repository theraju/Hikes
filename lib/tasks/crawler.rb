require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'anemone'
require 'digest/sha1'

Anemone.crawl("http://www.wta.org/go-hiking/hikes") do |anemone|
    anemone.on_every_page { |page| 

        #stuff that can be gleaned from the summary page
        #features list: div id="filter-features", input name="features:list" innertext
        #regions and subregions: regex match the "select name=region part"
        
        doc = Nokogiri::HTML(open(page.url))
        
        if (page.url.to_s.scan(%r|hikes$|).length > 0)
            puts page.url

            #hike data: tr class="hike-row"
            hikes_on_page = doc.css('tr[class=hike-row]')
            hikes_on_page.each { |hike|

            #within:
               #title: a class="hike-title" innertext
               title = hike.css('a.hike-title').first.content
               puts title
               puts Digest::SHA1.hexdigest title

               #avg_rating: div class="current-rating" innertext
               avg_rating = hike.css('div.current-rating').first.content
               puts avg_rating

               #vote_count: span class="VoteCount" innertext
               vote_count = hike.css('span.VoteCount').first.content
               puts vote_count

               #photo_url: a class="photo", within that img src
               photo_url = hike.css('a.photo').first

               if !photo_url.nil?
                   photo_link = photo_url.at_css('img')['src']
                   puts photo_link
               end
            }
        end

        if (page.url.to_s.scan(%r|(http://www.wta.org/go-hiking/hikes/([a-zA-Z0-9\-]+))$|).length > 0)
           #stuff from the detail page
           #description: div class="hike-full-description" innertext
           detail_title = doc.css('h1.documentFirstHeading').first.content
           puts detail_title
           puts Digest::SHA1.hexdigest detail_title

           desc = doc.css('div.hike-full-description').first.content

           #roundtrip, eleveation gain and high point: table class="stats-table" td label-cell is name, td data-cell is value
           #Labels are "Roundtrip", "Elevation gain" and "Highest point"
           stats = doc.css('table.stats-table')
           datacells = stats.css('td.data-cell')

           if (3 == datacells.count)
               puts datacells[0].content
               puts datacells[1].content
               puts datacells[2].content
           end

        end
    }

    anemone.focus_crawl { |page| 
        #links = []

        #get all hike detail pages
        follow = page.links.find_all{|link| link.to_s.scan(%r|(http://www.wta.org/go-hiking/hikes/([a-zA-Z0-9\-]+))$|).length > 0 } 
        
        # Find the 'next' link using css selectors
        doc = Nokogiri::HTML(open(page.url))
        next_link = doc.css('span[class=next]').first
        
        if (!next_link.nil?)
            uri = URI.parse(next_link.children().at_css('a')['href'])
            # follow << uri
        end

        next follow
    }
end
