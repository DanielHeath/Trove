class ItemController < ApplicationController

  active_scaffold :items do |config|
    config.columns = [:name, :description, :bonus, :body_slot, :private_notes, :main_image, :card_image]
    config.update.multipart = true
    config.create.multipart = true
    config.update.columns.exclude :card_image
    config.create.columns.exclude :card_image
    config.columns[:description].form_ui = :textarea
    config.columns[:private_notes].form_ui = :textarea
  end

end
