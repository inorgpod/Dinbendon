class Category < ApplicationRecord
  validates :name , presence: true

  has_many :items #建立關聯一對多 會做出四個方法
end
