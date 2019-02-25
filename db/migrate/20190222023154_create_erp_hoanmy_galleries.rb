class CreateErpHoanmyGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_hoanmy_galleries do |t|
      t.string :name
      t.string :description
      t.integer :custom_order
      t.string :alias
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
