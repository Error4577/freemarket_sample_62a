# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Database Architecture

## ERD
![ER図](https://imgur.com/n9fJpoL.png)

## users table
|Column|Type|Options|
|------|----|-------|
|e-mail|string|null: false, unique: true|
|password|string|null: false|
|nickname|string|null: false|
|phone_number|string|null: false, unique: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|date_of_birth|date|null: false|

### Association
- has_many :buyer_products, class_name: "product"
- has_many :seller_products, class_name: "product"
- has_many :comments
- has_many :messages
- has_many :addresses
- has_many :likes
- has_one :card
- has_one_attached :avatar

## products table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text|null: false|
|seller_id|references|null: false, foreign_key: { to_table: :users }|
|buyer_id|references|foreign_key: { to_table: :users }|
|category|references|null: false, foreign_key: true|
|brand|references|foreign_key: true|
|size|references|null: false, foreign_key: true|
|condition|integer|null: false|
|shipping_cost|integer|null: false|
|shipping_area|integer|null: false|
|shipping_date|integer|null: false|
|shipping_address|references|foreign_key:{ to_table: :addresses }|
|price|integer|null: false|

### Association
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- has_many :comments
- has_many :messages
- has_many :likes
- has_many_attached :images
- belongs_to :category
- belongs_to :brand
- belongs_to :size

## likes
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|
|status|boolean|null: false|

### Association
- belongs_to :user
- belongs_to :product

## categories
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :products
- has_many :category_brands
- has_many :brands, through: :category_brands
- has_many :category_sizes
- has_many :sizes, through: :category_sizes

## brands
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :products
- has_many :category_brands
- has_many :categories, through: :category_brands

## category_brands
|Column|Type|Options|
|------|----|-------|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|ancestry|string|null: false|

### Association
- belongs_to :category
- belongs_to :brand

## sizes table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :products
- has_many :category_sizes
- has_many :categories, through: :category_sizes

## category_sizes table
|Column|Type|Options|
|------|----|-------|
|category_id|references|null: false,foreign_key: true|
|size_id|references|null: false,foreign_key: true|

### Association
- belongs_to :category
- belongs_to :size

## comments table
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|product_id|references|null: false,foreign_key: true|
|user_id|references|null: false,foreign_key: true|

### Association
- belongs_to :product
- belongs_to :user

## messages
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|product_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :user

## addresses
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city_name|string|null: false|
|block_number|string|null: false|
|building_name|string||
|phone_number|string|null: false|

### Association
- belongs_to :user

## cards table
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user

## ActiveStorage::Attachment
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|record_type|string|null: false|
|record_id|integer|null: false|
|blob_id|integer|null: false|

## ActiveStorage::Blobs
|Column|Type|Options|
|------|----|-------|
|key|string|null: false|
|filename|string|null: false|
|content_type|string|null: false|
|metadate|text|null: false|
|byte_size|integer(8)|null: false|
|checksum|string|null: false|
