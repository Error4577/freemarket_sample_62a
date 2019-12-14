require "csv"

#ユーザー生成

@seller = User.create(
  nickname:         "出品用アカウント",
  password:         "1234abcd",
  email:            "hoge@hoge.com",
  date_of_birth:    "1996-11-20",
  last_name:        "てすと",
  first_name:       "たろう",
  last_name_kana:   "テスト",
  first_name_kana:  "タロウ",
  phone_number:     "12312341234"
)

@seller_address = Address.create(
  user:             @seller,
  last_name:        "たろう",
  first_name:       "ほげ",
  last_name_kana:   "タロウ",
  first_name_kana:  "ホゲ",
  postal_code:      "1231234",
  prefecture:       1,
  city_name:        "ほげ市",
  block_number:     "ふが番地",
  building_name:    "ぴよビル",
  phone_number:     "12312341234"
)

@buyer = User.create(
  nickname:         "購入用アカウント",
  password:         "1234abcd",
  email:            "fuga@fuga.com",
  date_of_birth:    "1996-11-20",
  last_name:        "てすと",
  first_name:       "たろう",
  last_name_kana:   "テスト",
  first_name_kana:  "タロウ",
  phone_number:     "12312341234"
)

@buyer_address = Address.create(
  user:             @buyer,
  last_name:        "じろう",
  first_name:       "ほげ",
  last_name_kana:   "ジロウ",
  first_name_kana:  "ホゲ",
  postal_code:      "1231234",
  prefecture:       47,
  city_name:        "ほげ市",
  block_number:     "ふが番地",
  building_name:    "ぴよビル",
  phone_number:     "12312341234"
)

i = 0
CSV.foreach("db/csv/root_categories.csv") do |row_root|
  root_category = Category.create(name: row_root[0])
  j = 0
  CSV.foreach("db/csv/child_categories/#{i}.csv") do |row_child|
    child_category = root_category.children.create(name: row_child[0])
    k = 0
    CSV.foreach("db/csv/grandchild_categories/#{i}-#{j}.csv") do |row_grandchild|
      grandchild_category = child_category.children.create(name: row_grandchild[0])
      k += 1
    end
    j += 1
  end
  i += 1
end

CSV.foreach("db/csv/sizes/0.csv") do |row_size|
  size = Size.create(name: row_size[0])
end

CSV.foreach("db/csv/brands.csv") do |row_brand|
  brand = Brand.create(name: row_brand[0])
end

