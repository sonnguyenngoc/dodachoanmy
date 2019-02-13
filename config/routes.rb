Erp::Hoanmy::Engine.routes.draw do
  root to: "frontend/home#index"
  
  get "tu-van-do-dac.html" => "frontend/service#consult_listing", as: :consult_listing
  get "tu-van-do-dac/chi-tiet.html" => "frontend/service#consult_detail", as: :consult_detail
  get "thu-tuc-dat-dai.html" => "frontend/service#procedure_listing", as: :procedure_listing
  get "thu-tuc-dat-dai/chi-tiet.html" => "frontend/service#procedure_detail", as: :procedure_detail
  
  get "du-an.html" => "frontend/project#listing", as: :project_listing
  get "du-an/chi-tiet.html" => "frontend/project#detail", as: :project_detail
  
  get "thu-vien-anh.html" => "frontend/gallery#listing", as: :gallery_listing
  get "thu-vien-anh/chi-tiet.html" => "frontend/gallery#detail", as: :gallery_detail
  
  get "tin-chuyen-nganh.html" => "frontend/blog#listing", as: :blog_listing
  get "tin-chuyen-nganh/chi-tiet.html" => "frontend/blog#detail", as: :blog_detail
  
  get "gioi-thieu.html" => "frontend/information#about_us", as: :about_us
end