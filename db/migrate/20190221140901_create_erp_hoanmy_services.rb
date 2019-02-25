class CreateErpHoanmyServices < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_hoanmy_services do |t|
      t.string :icon_url
      t.string :image_url
      t.string :name
      t.string :alias
      t.string :description
      t.string :content
      t.string :meta_keywords
      t.string :meta_description
      t.string :category
      t.string :show_name
      t.integer :custom_order
      t.boolean :is_show, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
