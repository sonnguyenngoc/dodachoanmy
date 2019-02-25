module Erp
  module Hoanmy
    module Frontend
      class ProjectController < Erp::Frontend::FrontendController
        def listing
          @projects = Erp::Hoanmy::Project.get_projects(params).limit(9)
        end
        
        def detail
          @project = Erp::Hoanmy::Project.find(params[:project_id])
          @meta_keywords = @project.meta_keywords
          @meta_description = @project.meta_description
          @projects = Erp::Hoanmy::Project.get_projects(params).limit(5)
        end
      end
    end
  end
end