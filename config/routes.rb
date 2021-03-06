Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, :at => '/'
          # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'spree/home#index'


 namespace :api, defaults: {format: 'json'} do
    scope module: :v1 do
      #Métodos para registro y token
       post 'register_group' => 'b2b#create_group'
       get 'get_token' => 'b2b#get_token'
      #Métodos para orden de compra
       post 'create_order' => 'b2b#create_order'
       delete 'canceled_order' => 'b2b#canceled_order'
       put 'accepted_order' => 'b2b#accepted_order'
       put 'rejected_order' => 'b2b#rejected_order'
      #Métodos para las facturas
       post 'issued_invoice' => 'b2b#issued_invoice'
       put 'invoice_paid' => 'b2b#invoice_paid'
       put 'rejected_invoice' => 'b2b#rejected_invoice'
      #Documentacion
       get 'documentation' => 'b2b#documentation', defaults: {format: 'html'}
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


end
