# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create_commit :create_setting, :create_default_deck
  
  has_one :setting
  has_many :cards
  has_many :decks
  has_many :favorites 
  has_many :favorite_questions, through: :favorites

  delegate :openai_key, to: :setting
  delegate :openai_proxy, to: :setting
  delegate :llm_model, to: :setting
  
  private 
    def create_setting
      Setting.create!(user_id: id)  
    end

    def create_default_deck
      Deck.create!(name: 'default', user_id: id)
    end
end
