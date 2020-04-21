class Item < ApplicationRecord
  validates :name , presence: true
  validates :price , presence: true , 
            numericality:{ greater_than: 0 }

  has_many :comments
  belongs_to :category
  has_many :users, through: :favorite_items
  has_many :favorite_items
  has_one_attached :cover
  scope :available, -> { where(deleted_at: nil) }
  # default_scope { where(deleted_at: nil)}
  # scope :cheap, -> {where ("price<=50") }

  def destroy
    update(deleted_at: Time.now)
  end

  def favorited_by(u)
    u.items.include?(self) #用使用者的物品去查詢物品自己是否在陣列裡
  end
end




