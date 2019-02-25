class CreateErpHoanmyProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_hoanmy_projects do |t|      
      t.string :name
      t.string :alias
      t.string :content
      t.datetime :start_time
      t.string :investor
      t.string :address
      t.string :status, default: "processing"
      t.string :meta_keywords
      t.string :meta_description
      t.integer :custom_order
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
