require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'john', email: 'john@gmail.com', password: '12341234') }
  subject { described_class.new(user:, name: 'Apple', measurement_unit: 'grams', price: 10, quantity: 1) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without user' do
      subject.user = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without measurement_unit' do
      subject.measurement_unit = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with an invalid price or quantity' do
      subject.price = 'invalid price'
      subject.quantity = 'invalid quantity'
      expect(subject).not_to be_valid
    end
  end
end
