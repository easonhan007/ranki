class HomeController < ApplicationController
  before_action :can_quick_new_card

  def index
    default_order = 'updated_at DESC'
    @decks = current_user.decks.recent
    @cards = current_user.cards.recent
  end
end
