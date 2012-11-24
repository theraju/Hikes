task :crawl => :environment do
require 'rubygems'
puts Gem.path
require 'nokogiri'
require 'open-uri'
require 'anemone'
require 'digest/sha1'


Anemone.crawl("http://www.wta.org/go-hiking/hikes") do |anemone|
    anemone.on_every_page { |page| 

        
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
               # hash_key = Digest::SHA1.hexdigest title

               trail = Trail.find_or_initialize_by_title(title)

               #avg_rating: div class="current-rating" innertext
               avg_rating = hike.css('div.current-rating').first.content
               puts avg_rating
               trail.avg_rating = avg_rating

               #vote_count: span class="VoteCount" innertext
               vote_count = hike.css('span.VoteCount').first.content
               puts vote_count
               trail.vote_count = vote_count

               #photo_url: a class="photo", within that img src
               photo_url = hike.css('a.photo').first

               if !photo_url.nil?
                   photo_link = photo_url.at_css('img')['src']
                   puts photo_link
                   trail.photo_url = photo_link
               end

               # td class cell-metadata, ul->li <label> is Features: <span> is feature values comma separated
               metadata = hike.css('td.cell-metadata').first
               list = metadata.css('ul').first
               
#new hikes dont have this info
               if list && list.css('li')
                   list_items = list.css('li')
                   list_items.each { |each_item|
                    if (each_item.css('label').inner_text.include? 'Features')
                        features = each_item.css('span').inner_text.split(',')
                        features.each { |feature|
                            feature_model = Feature.find_by_name(feature.strip)
                            trail.features << feature_model
                        }
                    end
                   }
               end

               trail.save
            }
        end

        if (page.url.to_s.scan(%r|(http://www.wta.org/go-hiking/hikes/([a-zA-Z0-9\-]+))$|).length > 0)
           #stuff from the detail page
           #description: div class="hike-full-description" innertext
           detail_title = doc.css('h1.documentFirstHeading').first.content
           puts detail_title
           # puts Digest::SHA1.hexdigest detail_title

           trail = Trail.find_or_initialize_by_title(detail_title)

           desc = doc.css('div.hike-full-description').first.content
           trail.description = desc

           #roundtrip, eleveation gain and high point: table class="stats-table" td label-cell is name, td data-cell is value
           #Labels are "Roundtrip", "Elevation gain" and "Highest point"
           stats = doc.css('table.stats-table')
           datacells = stats.css('td.data-cell')

           if (3 == datacells.count)
               puts datacells[0].content
               miles_match = datacells[0].content.scan(%r|([0-9]+.[0-9]+)\s+miles|)
               if (miles_match.length > 0)
                   trail.round_trip = miles_match[0]
               end
               puts datacells[1].content
               elev_match = datacells[1].content.scan(%r|([0-9]+.[0-9]+)\s+ft|)
               if (elev_match.length > 0)
                   trail.elevation_gain = elev_match[0]
               end
               puts datacells[2].content
              high_match = datacells[2].content.scan(%r|([0-9]+.[0-9]+)\s+ft|)
               if (high_match.length > 0)
                   trail.high_point = high_match[0]
               end
           end
           trail.save

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
end
