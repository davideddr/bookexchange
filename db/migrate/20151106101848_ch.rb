class Ch < ActiveRecord::Migration
  def change
  	add_column :provides, :delivered, :boolean , default: false
  end
end
