module Erp::Hoanmy
  class ProjectImage < ApplicationRecord
    belongs_to :project, optional: true
    mount_uploader :image_url, Erp::Hoanmy::ProjectUploader

    default_scope { order(id: :desc) }
  end
end
