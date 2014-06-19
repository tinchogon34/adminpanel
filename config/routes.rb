Rails.application.routes.draw do
  devise_for :admins
  resources :domains, controller: :postfix_domains, constraints: {id: /[^\/]+/} do
    resources :mailboxes, shallow: true
  end

  resources :zones, controller: :dns_domains do
    resources :records, shallow: true    
  end

  root 'dns_domains#index'
end
