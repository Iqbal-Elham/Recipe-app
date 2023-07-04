class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipes_foods
  has_many :foods, through: :recipes_foods

  validates :name, presence: true
  validates :description, presence: true
end
