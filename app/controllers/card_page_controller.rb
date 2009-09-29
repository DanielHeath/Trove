class CardPageController < ApplicationController

  active_scaffold :card_pages do |config|
    config.columns = [:image]
    config.actions = [:list, :delete]
  end

end
