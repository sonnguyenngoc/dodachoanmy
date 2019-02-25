module Erp::Hoanmy
  class GalleryImage < ApplicationRecord
    belongs_to :gallery, optional: true
    mount_uploader :image_url, Erp::Hoanmy::GalleryUploader

    default_scope { order(id: :desc) }
  end
end
