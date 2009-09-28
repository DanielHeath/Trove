class CreateItemListItems < ActiveRecord::Migration
  def self.up
    create_table :item_list_items do |t|
      t.integer :item_id
      t.integer :item_list_id
      t.timestamps
      t.index [:item_id, :item_list_id], :unique => true
    end
  end

  def self.down
    drop_table :item_list_items
  end
end
