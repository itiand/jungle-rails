class Product < ApplicationRecord
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price_cents, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0}
  validates :category, presence: true
end
