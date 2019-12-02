Rails.application.routes.draw do
  resources :restaurants, except: %i[edit] do
    resources :menus, except: %i[edit]
  end

  resources :users, except: %i[edit] do
    resources :orders, except: %i[edit]
  end
end
