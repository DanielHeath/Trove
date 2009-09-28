class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :private_notes
      t.string :main_image
      t.string :card_image
      t.string :body_slot
      t.string :bonus
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
