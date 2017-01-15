Rails.application.routes.draw do
  devise_for :users

  match 'wishlist/insert' => 'wishlist#insert', via: [:get, :post]
  match 'wishlist/remove' => 'wishlist#remove', via: [:get, :post]
  match 'provides/prov' => 'provides#prov', via: [:get, :post]
  match 'books/gbsearch' => 'books#gbsearch', via: [:get, :post]
  match 'books/search' => 'books#search', via: [:get, :post]
  match 'books/req' => 'books#req', via: [:get, :post]
  get 'books/received'
  get 'books/requests'
  match 'books/remove' => 'books#remove', via: [:get, :post]
  get 'books/show_info'

  resources :books do
    collection do
      get 'autocomplete_book_title'
    end
  end

  root to: 'interface#index'
end
