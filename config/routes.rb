Rails.application.routes.draw do
  get "/forecasts" => "forecasts#index"
end
