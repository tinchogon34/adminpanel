Rails.application.routes.draw do
  resources :domains, controller: :postfix_domains, constraints: {id: /[^\/]+/} do
    resources :mailboxes, shallow: true
  end

  resources :zones, controller: :dns_domains do
    resources :records, shallow: true    
  end

  # root 'welcome#index'
end
