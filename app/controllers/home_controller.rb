class HomeController < ApplicationController
  def index
    default_order = 'updated_at DESC'
    @decks = current_user.decks.recent
    @cards = current_user.cards.recent
  end
end
