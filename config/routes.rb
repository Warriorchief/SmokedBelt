Rails.application.routes.draw do
  get '/' => 'user#index'

  post '/register' => 'user#register'

  get '/already' => 'user#already'

  post '/login' => 'user#login'

  get '/profile/:id' => 'user#profile'

  post '/delete_idea/:id' => 'user#delete_idea'

  post '/like_idea/:id' => 'user#like_idea'

  post '/new_idea' => 'user#new_idea'

  get '/show_user/:id' => 'user#show_user'

  get '/show_idea_likers/:id' => 'user#show_idea_likers'

  get '/logout' => 'user#logout'

end
