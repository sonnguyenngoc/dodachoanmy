module Erp
  module Hoanmy
    module Frontend
      class GalleryController < Erp::Frontend::FrontendController
        def listing
          @galleries = Erp::Hoanmy::Gallery.get_galleries(params)
        end
      end
    end
  end
end