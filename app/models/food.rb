class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes_foods, dependent: :delete_all
  has_many :recipes, through: :recipes_foods

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, message: 'must be a decimal number' }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: 'must be an integer' }
end
