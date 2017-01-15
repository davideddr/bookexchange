class CreateProvides < ActiveRecord::Migration
  def change
    create_table :provides do |t|

      t.timestamps null: false
    end
  end
end
