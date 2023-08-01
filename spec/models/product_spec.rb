require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    category = Category.new(name: "Blue Plants")
    it 'should not save without a name' do
      product = Product.new(
        name: nil,
        price: 100,
        quantity: 10,
        category: category
      )

      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save without a price' do
      product = Product.new(
        name: 'Lava Plant',
        price: nil,
        quantity: 10,
        category: category
      )

      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Price cents must be greater than 0")
    end

    it 'should not save without a quantity' do
      product = Product.new(
        name: 'Lava Plant',
        price: 25,
        quantity: nil,
        category: category
      )

      expect(product.save).to be false;
      product.valid?
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without a category' do
      product = Product.new(
        name: 'Lava Plant',
        price: 25,
        quantity: 20,
        category: nil
      )

      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Category can't be blank")

    end

  end
end
