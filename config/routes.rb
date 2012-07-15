Project::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Forum::Engine => '/forum', :as => 'forum'

  authenticated :user do
    root :to => 'profile#index'
  end
  root :to => "home#index"

  devise_for :users
  resources :users, :only => :show

  get 'members/list' => 'members#list'
  get 'members/view/:id' => 'members#view', :as => "member_view"
  get 'members' => 'members#all'
  post 'members/:id/comment' => 'members#comment', :as => "timeline_comment"
  get 'messages' => 'messages#index'
  post 'messages' => 'messages#create'
  get 'messages/compose' => 'messages#compose'
  get 'messages/notifications' => 'messages#notifications'
  get 'messages/search' => 'messages#search'
  get 'profile' => 'profile#index'
  get 'profile/settings' => 'profile#settings'
  put 'avatar' => 'profile#crop_update'
  put 'profile/update' => 'profile#update', :as => "update_profile"
  get 'calendar' => 'calendar#index'
  get 'community' => 'community#index'
  get 'manual' => 'manual#index'

  resources :library
  resources :expression

  # Actions
  post 'follow' => 'actions#follow'
  post 'unfollow' => 'actions#unfollow'
  post 'vote' => 'actions#vote'
  post 'tag' => 'actions#tag'
  post 'untag' => 'actions#untag'
  post 'favorite' => 'actions#favorite'
  post 'unfavorite' => 'actions#unfavorite'
  post 'comment' => 'actions#comment'


  get 'slides' => 'slides#index'

  # Events
  get 'events' => 'events#list'
  post 'events' => 'events#create'
  put 'events/:id' => 'events#update'

end
