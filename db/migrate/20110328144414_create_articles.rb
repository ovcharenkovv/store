class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.string :meta_k
      t.string :meta_d
      t.text :body
      t.string :slug
      t.integer :views

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end