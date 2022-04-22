Rails.application.routes.draw do
  root to: proc { [200, {}, ['ok']] }

  scope '/auth' do
    get '/emails/:email/available', to: 'auth#check_available_email', email: /[^\/]+/
    post '/sign_in', to: 'auth#sign_in'
    post '/sign_up', to: 'auth#sign_up'
    post '/sign_out', to: 'auth#sign_out'
  end

  scope '/users' do
    get '/me', to: 'users#show'
  end

  resources :posts do
    post '/likes', action: :like
    delete '/likes', action: :unlike
  end

=begin
  scope '/api' do
    post '/user/logout', to: 'auth#sign_out'
    post '/user/check', to: 'users#show'

    get '/post', to: 'posts#index'
    get '/post/:id', to: 'posts#show'
    post '/post', to: 'posts#create'
    patch '/post/:id', to: 'posts#update', id: /[0-9]+(\%7C[0-9]+)*/
    delete '/post/:id', to: 'posts#destroy', id: /[0-9]+(\%7C[0-9]+)*/

    post '/post/like', to: 'posts#like'
    delete '/post/like', to: 'posts#unlike'
  end
=end
end
