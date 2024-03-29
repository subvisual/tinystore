class Product < ActiveRecord::Base
  belongs_to :store

  mount_uploader :picture, ProductPictureUploader

  monetize :price_cents

  acts_as_paranoid

  validates_presence_of :name, :price
  validates :description, length: { maximum: 140 }
  validates :price, numericality: { greater_than: 0 }
end
