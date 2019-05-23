class WeatherController < ApplicationController

  def index

    render json: resp.reject{|req| req == {}}, status: 201
  end

  def show

  end

  def destroy

  end

  def create
    resp = Weather.new weather_params
    if resp.save
      render json: resp , status: 200
    else
      render json: resp.errors  , status: 400
    end
  end

  def get_weather_by_date
     render json: Weather.where(date: params[:date]) , status: 200
  end

  def get_weather_by_location
    render json: Weather.joins(:locations).where("locations.lat = ? AND location.lon = ?", params[:lat] , params[:lon]), status: 200
  end

  def destroy
    Weather.joins(:locations).where("locations.lat = ? AND location.lon = ? and start_date = ? and end_date = ?", params[:lat] , params[:lon] , params[:start_data] , params[:end_date]).destroy_all
    render json: {} , status: 200

  end
  # def get_all
  #
  #   puts "\n\n\n\n -------GET------- \n\n\n\n"
  #
  #
  #   path = File.join(Rails.root, 'spec', 'helpers')
  #   files = ['http00.txt']
  #
  #   data = File.open(File.join(path, files[0])).read
  #
  #   puts data
  #
  #   resp =[]
  #   data.each_line do |row|
  #     req = JSON.parse(row)
  #     resp << req["request"]["body"]
  #   end
  #
  #
  #   render json: resp.reject{|req| req == {}}, status: 200
  #
  # end
  #

  private

  def weather_params
    params.permit(:id, :date , :location , :temperature)
  end
end
