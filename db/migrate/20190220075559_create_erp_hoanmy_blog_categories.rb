class CreateErpHoanmyBlogCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :erp_hoanmy_blog_categories do |t|
      t.string :name
      t.string :description
      t.integer :parent_id
      t.string :alias
      t.integer :custom_order
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end