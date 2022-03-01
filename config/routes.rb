Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:create, :index, :edit, :update]
    resources :items, only: [ :new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: 'public' do
    root to: 'homes#top'
    get '/about'=> 'homes#about', as: 'about'
    get '/customers/my_page' => 'customers#show'
    get '/customers/edit' => 'customers#edit'
    patch '/customers' => 'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'
    resources :addresses, only: [:create, :index, :update, :edit, :destroy]
    resources :items, only: [:show, :index]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'all_destroy'
    resources :cart_items, only: [:create, :index, :update, :destroy]
    get '/orders/new' => 'orders#new'
    post '/orders/comfirm' => 'orders#comfirm'
    get '/orders/complete' => 'orders#complete'
    resources :orders, only:  [:create, :index, :show]
  end

end
