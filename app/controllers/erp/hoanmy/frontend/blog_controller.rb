module Erp
  module Hoanmy
    module Frontend
      class BlogController < Erp::Frontend::FrontendController
        def listing
          @blogs = Erp::Hoanmy::Blog.get_blogs(params).paginate(:page => params[:page], :per_page => 6)
          @consultant_services = Erp::Hoanmy::Service.get_home_consultant_services(params)
          @procedure_services = Erp::Hoanmy::Service.get_home_procedure_services(params)
          @galleries = Erp::Hoanmy::Gallery.get_galleries(params)
        end
        
        def detail
          @blog = Erp::Hoanmy::Blog.find(params[:blog_id])
          @meta_keywords = @blog.meta_keywords
          @meta_description = @blog.meta_description
          @blogs = Erp::Hoanmy::Blog.get_blogs(params).limit(5)
        end
      end
    end
  end
end