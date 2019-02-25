module Erp
  module Hoanmy
    class ProjectUploader < CarrierWave::Uploader::Base
      include CarrierWave::MiniMagick
      
      storage :file
      
      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
      
      version :small do
        process resize_to_fill: [120, 120]
      end
      
      version :system do
        process resize_to_fill: [150, 150]
      end
      
      version :medium do
        process resize_to_fill: [350, 220]
      end
      
      version :large do
        process resize_to_fill: [800, 500]
      end
    end
  end
end