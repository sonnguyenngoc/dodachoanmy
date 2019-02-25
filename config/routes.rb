Erp::Hoanmy::Engine.routes.draw do
  root to: "frontend/home#index"
  
  get "tu-van-do-dac.html" => "frontend/service#consult_listing", as: :consult_listing
  get "tu-van-do-dac/chi-tiet.html" => "frontend/service#consult_detail", as: :consult_detail
  get "thu-tuc-dat-dai.html" => "frontend/service#procedure_listing", as: :procedure_listing
  get "thu-tuc-dat-dai/chi-tiet.html" => "frontend/service#procedure_detail", as: :procedure_detail
  
  get "du-an.html" => "frontend/project#listing", as: :project_listing
  get "du-an/(/:project_id)(/:title).html" => "frontend/project#detail", as: :project_detail
  
  get "thu-vien-anh.html" => "frontend/gallery#listing", as: :gallery_listing
  
  get "tin-chuyen-nganh.html" => "frontend/blog#listing", as: :blog_listing
  get "tin-chuyen-nganh(/:blog_id)(/:title).html" => "frontend/blog#detail", as: :blog_detail
  
  get "gioi-thieu.html" => "frontend/information#about_us", as: :about_us
  
  scope "(:locale)", locale: /en|vi/ do
    namespace :backend, module: "backend", path: "hoanmy/backend" do
      resources :blogs do
        collection do
          post 'list'
          get 'dataselect'
          put 'move_up'
          put 'move_down'
        end
      end
      
      resources :blog_categories do
        collection do
          post 'list'
          get 'dataselect'
          put 'move_up'
          put 'move_down'
        end
      end
      
      resources :projects do
        collection do
          post 'list'
          put 'move_up'
          put 'move_down'
        end
      end
      
      resources :galleries do
        collection do
          post 'list'
          put 'move_up'
          put 'move_down'
        end
      end
      
      resources :services do
        collection do
          post 'list'
          put 'move_up'
          put 'move_down'
        end
      end
    end
  end
end