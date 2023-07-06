require 'rails_helper'

RSpec.describe 'Foods', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'iqbal', email: 'iqbal@gmail.com', password: '123456')
    @food = Food.create(user_id: @user.id, name: 'Apple', measurement_unit: 'grams', price: 10, quantity: 1)
    login_as(@user, scope: :user)
  end

  describe 'Foods CRUD' do
    it 'displays the list of foods' do
      visit foods_path
      expect(page).to have_content(@food.name)
      expect(page).to have_content(@food.measurement_unit)
      expect(page).to have_content(@food.price)
      expect(page).to have_content(@food.quantity)
    end

    it 'allows creation of a new food' do
      visit new_food_path
      fill_in 'Name', with: 'Banana'
      fill_in 'Measurement unit', with: 'pieces'
      fill_in 'Price', with: 5
      fill_in 'Quantity', with: 3
      click_button 'Create Food'
      expect(page).to have_content('Food was successfully created.')
      expect(page).to have_content('Banana')
    end

    it 'allows deletion of a food' do
      visit foods_path
      click_button 'Delete'
      expect(page).to have_content('Food was successfully destroyed.')
      expect(page).not_to have_content(@food.name)
    end
  end
end
