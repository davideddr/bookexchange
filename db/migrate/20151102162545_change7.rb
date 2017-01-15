class Change7 < ActiveRecord::Migration
  def change
  	create_table :wishlists do |t|
      t.belongs_to :book, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
