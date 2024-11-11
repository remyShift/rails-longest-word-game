Rails.application.routes.draw do
  root "games#new", as: "new"
  get "/score", to: "games#score", as: "score"
  post "/score", to: "games#score"
end
