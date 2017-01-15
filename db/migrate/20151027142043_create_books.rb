class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :autor
      t.string :publisher
      t.integer :isbn
      t.integer :pages
      t.integer :year
      t.text :description
      t.string :bookbinding
      t.string :language
      t.string :category
      t.string :typeOfSale
      t.string :status

      t.timestamps null: false
    end
  end
end
