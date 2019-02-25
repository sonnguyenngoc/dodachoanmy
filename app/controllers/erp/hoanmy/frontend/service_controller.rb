module Erp
  module Hoanmy
    module Frontend
      class ServiceController < Erp::Frontend::FrontendController
        def consult_listing
          @consultant_services =  Erp::Hoanmy::Service.get_consultant_services(params)
        end
        
        def consult_detail         
        end
        
        def procedure_listing
          @procedure_services =  Erp::Hoanmy::Service.get_procedure_services(params)
        end
        
        def procedure_detail
        end
      end
    end
  end
end