class Change4 < ActiveRecord::Migration
  def change
  	drop_table :books
  	create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :isbn
      t.integer :pages
      t.integer :year
      t.text :description
      t.string :bookbinding
      t.string :language
      t.string :category
      t.string :typeOfSale
      t.string :status
      t.belongs_to :user
      
      t.timestamps null: false
    end
  end
end
