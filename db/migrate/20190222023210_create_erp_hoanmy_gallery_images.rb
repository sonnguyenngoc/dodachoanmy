class CreateErpHoanmyGalleryImages < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_hoanmy_gallery_images do |t|
      t.string :image_url
      t.string :image_url_cache
      t.references :gallery, index: true, references: :erp_hoanmy_galleries

      t.timestamps
    end
  end
end
