class CreateCardPages < ActiveRecord::Migration
  def self.up
    create_table :card_pages do |t|
      t.string :item_list_id
      t.string :image
      t.timestamps
    end
  end

  def self.down
    drop_table :card_pages
  end
end
