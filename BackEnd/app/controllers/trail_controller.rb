class TrailController < ApplicationController
  def search
#params are: roundtriplte, roundtripgte, elevgainlte, elevgaingte, ratinggte
    results = Trail.where{ }

    if (params.has_key?('roundtripgte') || params.has_key?('roundtriplte'))
        results = results.where{ round_trip ^ nil }
    end
    rt_gte = params[:roundtripgte].to_i
    if (rt_gte > 0)
        results = results.where{ round_trip >= rt_gte }
    end

    rt_lte = params[:roundtriplte].to_i
    if (rt_lte > 0)
        results = results.where{ round_trip <= rt_lte }
    end
    
    if (params.has_key?('elevgainlte') || params.has_key?('elevgaingte'))
        results = results.where{ elevation_gain ^ nil }
    end

    elevgain_lte = params[:elevgainlte].to_i
    if (elevgain_lte > 0)
        results = results.where{ elevation_gain <= elevgain_lte }
    end 

    elevgain_gte = params[:elevgaingte].to_i
    if (elevgain_gte > 0)
        results = results.where{ elevation_gain >= elevgain_gte }
    end 

    rating_gte = params[:ratinggte].to_i
    if (rating_gte > 0)
        results = results.where{ avg_rating ^ nil }
        results = results.where{ avg_rating >= rating_gte }
    end 

    render :json => results
  end

  def index
    trails = Trail.all; render :json => trails
    # render :json => Feature.find(:first)
  end
end
