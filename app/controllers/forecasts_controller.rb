class ForecastsController < ApplicationController
  def index
    input_city = params[:form_city] || "Chicago"
    input_state = params[:form_state] || "IL"
    response = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{input_city}%2C%20#{input_state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")
    @weather_data = response.body
    @temperature = @weather_data["query"]["results"]["channel"]["item"]["condition"]["temp"]
    @location = @weather_data["query"]["results"]["channel"]["description"].split("for")[1]
    @forecast_days = @weather_data["query"]["results"]["channel"]["item"]["forecast"]
    render "index.html.erb"
  end
end
