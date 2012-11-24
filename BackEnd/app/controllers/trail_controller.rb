class TrailController < ApplicationController
  def search
    results = Trail.all
    rt_gte = params[:roundtripgte].to_i
    if (rt_gte > 0)
        results = Trail.where{ (round_trip ^ nil) & (round_trip >= rt_gte) }
    end

    rt_lte = params[:roundtriplte].to_i

    if (rt_lte > 0)
        results = Trail.where{id.in(results.select{id})}.where{ (round_trip ^ nil ) & (round_trip <= rt_lte) }
    end
    
    elevgain_lte = params[:elevgain].to_i
    if (elevgain_lte > 0)
        results = Trail.where{id.in(results.select{id})}.where{ (elevation_gain ^ nil) & (elevation_gain <= elevgain_lte) }
    end 

    render :json => results
  end

  def index
    trails = Trail.all; render :json => trails
    # render :json => Feature.find(:first)
  end
end
