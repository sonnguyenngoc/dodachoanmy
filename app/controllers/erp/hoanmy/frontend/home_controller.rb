module Erp
  module Hoanmy
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @projects = Erp::Hoanmy::Project.get_projects(params).limit(3)
          @consultant_services =  Erp::Hoanmy::Service.get_home_consultant_services(params).limit(9)
          @procedure_services =  Erp::Hoanmy::Service.get_home_procedure_services(params).limit(9)
        end
      end
    end
  end
end
