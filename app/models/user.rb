class User < ApplicationRecord
    #validates
    validates :email,presence: true , uniqueness: true;
    validates :password ,presence: true , confirmation: true , length:{ minimum: 4 }

    # attr_accessor :password_confirm
    


    #relationship
    has_many :histories 
    has_many :events , through: :histories
    has_many :comments

    has_many :favorite_items
    has_many :items, through: :favorite_items
end
