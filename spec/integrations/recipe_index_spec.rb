require 'rails_helper'

RSpec.describe 'Integration tests for the recipes index view', type: :feature do
    include Devise::Test::IntegrationHelpers
  before(:each) do
    @user = User.create(name: 'iqbal', email: 'iqbal@gmail.com', password: '123456')
    @recipe = Recipe.create(name: 'Kabab', description: 'A delicious food', user_id: @user.id)
    login_as(@user, scope: :user)
    visit recipes_path
  end

  describe 'GET /index' do

    it 'should render the title of the page' do
      expect(page).to have_content('Recipes')
    end

    it 'should render the name of the recipe' do
      expect(page).to have_content('Kabab')
    end

    it 'should render the description of the recipe' do
      expect(page).to have_content('A delicious food')
    end

    it 'should have a link to add a new recipe' do
      expect(page).to have_link('+Add a new recipe', href: new_recipe_path)
    end
  end
end