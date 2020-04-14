class Item < ApplicationRecord
  validates :name , presence: true
  validates :price , presence: true , 
            numericality:{ greater_than: 0 }
  
  belongs_to :category
  
  has_one_attached :cover
  scope :available, -> { where(deleted_at: nil) }
  # default_scope { where(deleted_at: nil)}
  # scope :cheap, -> {where ("price<=50") }

  def destroy
    update(deleted_at: Time.now)
  end
end




