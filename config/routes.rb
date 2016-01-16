Rails.application.routes.draw do
  root :to => "page#index"
  get "/view/:id" => "page#view"
  get "/dot/:id" => "page#dot"
  post "/upload" => "page#upload"
end
