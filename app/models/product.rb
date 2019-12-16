class Product < ApplicationRecord
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id", optional: true
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :size
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture, class_name: "Prefecture", foreign_key: "shipping_area"
  belongs_to_active_hash :ship_date, class_name: "Shipping_date", foreign_key: "shipping_date"
  belongs_to_active_hash :ship_cost, class_name: "Shipping_cost", foreign_key: "shipping_cost"
  belongs_to_active_hash :item_condition, class_name: "Condition", foreign_key: "condition"

  def validate_images
    return unless images.attached?

  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
  end
end
