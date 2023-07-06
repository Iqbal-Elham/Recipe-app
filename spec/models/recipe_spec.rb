require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'iqbal', email: 'iqbal@email.com', password: '123456') }
  let(:recipe) { Recipe.create(name: 'Qabli', description: 'A delicious food', user_id: user.id) }

  context 'validations' do
    it('should be valid') do
      expect(recipe).to be_valid
    end

    it('should not be valid without a name') do
      recipe.name = nil
      expect(recipe).to_not be_valid
    end

    it('should not be valid without a description') do
      recipe.description = nil
      expect(recipe).to_not be_valid
    end
  end
end
