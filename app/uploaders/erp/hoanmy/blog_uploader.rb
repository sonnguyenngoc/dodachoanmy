module Erp
  module Hoanmy
    class BlogUploader < CarrierWave::Uploader::Base
      include CarrierWave::MiniMagick
      
      storage :file
      
      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
      
      version :system do
        process resize_to_fill: [150, 150]
      end
      
      version :small do
        process resize_to_fill: [65, 46]
      end
      
      version :medium do
        process resize_to_fill: [410, 290]
      end
      
      version :large do
        process resize_to_fill: [850, 380]
      end
    end
  end
end