class Change3 < ActiveRecord::Migration
  def change
  	drop_table :provides
  	create_table :provides do |t|
      t.belongs_to :book, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
