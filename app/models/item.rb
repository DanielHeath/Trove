SLOT_UNSLOTTED = "Unslotted"
#BODY_SLOTS = ["Armour", "Weapon", "Amulet", "Goggles", "Boots", SLOT_UNSLOTTED]
BODY_SLOTS = (CardGen::Template.config["images"].keys + [SLOT_UNSLOTTED]).uniq

class Item < ActiveRecord::Base
  has_many :item_list_items
  has_many :item_lists, :through => :item_list_items
  validates_inclusion_of :body_slot, :in => BODY_SLOTS
  validates_uniqueness_of :name
  before_save :generate_card_image
  
  file_column :main_image
  file_column :card_image
  
  def self.valid_slots
    BODY_SLOTS
  end
  
  def self.default_slot
    SLOT_UNSLOTTED
  end

  def generate_card_image
    template = CardGen::Template.new(name, description, bonus, body_slot, main_image)
    template.output_file = output_file = File.join(RAILS_ROOT, 'tmp', 'images', 'card.png')
    template.generate_card
    File.open(output_file) do |f|
      f.extend FileColumn::FileCompat
      self.card_image = f
    end
  end
  
end
