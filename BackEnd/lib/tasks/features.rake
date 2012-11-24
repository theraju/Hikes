task :features => :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'anemone'
    require 'digest/sha1'


    Anemone.crawl("http://www.wta.org/go-hiking/hikes") do |anemone|
        anemone.on_every_page { |page| 
            
            doc = Nokogiri::HTML(open(page.url))
            
            puts page.url
        
            #stuff that can be gleaned from the summary page
            #features list: div id="filter-features", input name="features:list" innertext
            features = doc.css('#filter-features')
            features.css('input[type=checkbox]').each { |featuretag|
                feature_text = featuretag['value'].strip
                if feature_text && feature_text == "on"
                    # for some, the value is 'on' and the text we want is on 'name'
                    feature_text = featuretag['name'].strip
                end
                if feature_text && feature_text.length > 0
                    feature = Feature.find_or_initialize_by_name feature_text
                    puts feature.name
                    feature.save
                end
            }

            #regions and subregions: regex match the "select name=region part"

        }

        anemone.focus_crawl { |page|
            links = []
        }
    end
end
