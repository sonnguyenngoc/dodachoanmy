class CreateErpHoanmyProjectImages < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_hoanmy_project_images do |t|
      t.string :image_url
      t.string :image_url_cache
      t.references :project, index: true, references: :erp_hoanmy_projects

      t.timestamps
    end
  end
end