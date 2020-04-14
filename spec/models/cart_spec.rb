require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) {Cart.new} #方法同下 是讓cart變成方法 依據放置的位置可以坐用在不同層級的作用區域裡,如此一來區域內的Cart.new都可以省略不寫
  # def cart
  #   @cart ||= Cart.new
  # end 

  describe "基本功能" do
      it "可以把商品丟到購物車裡,然後購物車就有東西了" do
        cart = Cart.new
        cart.add_item(1)
        expect(cart.empty?).to be false
        #expect(cart).not_to be_empty ((((意義同上
      end
    
      
      it "加了相同種類的傷到購物車裡,購買項目不會新增欄位" do 
        
    
        3.times { cart.add_item(1)}
        2.times { cart.add_item(2)}
        2.times { cart.add_item(1)}
        # cart.add_item(1)
        # cart.add_item(1)
        # cart.add_item(2)
        # cart.add_item(1)
        
        expect(cart.items.count).to be 2
      end
    
  
    it "商品可放到購物車也可再拿出" do 
      #arrange
      cart = Cart.new 
      
      #cat1 = Category.create(name: 'cat1')
      #cat1 = FactoryBot.create(name: 'cat1')
      i1 = FactoryBot.create(:item) 
      i2 = FactoryBot.create(:item) 
  
      #act 
      3.times { cart.add_item(i1.id)}
      2.times { cart.add_item(i2.id)}
  
      #assert
      expect(cart.items.first.item).to be_an Item #be_a , be_an 是RSpec的一種方法 判斷是否為方法
      expect(cart.items.first.item.price).to be i1.price
    end

    it "可以計算整台購物車的總消費金額" do
      # Arrange
      cart = Cart.new

      i1 = FactoryBot.create(:item, price: 50)
      i2 = FactoryBot.create(:item, price: 100)
      
      # Act
      3.times { cart.add_item(i1.id) }
      2.times { cart.add_item(i2.id) }

      # Assert
      expect(cart.total).to be 350
    end

    it "特別活動可能可搭配折扣" do 
      
        #4/1
        # Arrange
        # cart = Cart.new
  
        i1 = FactoryBot.create(:item, price: 50)
        i2 = FactoryBot.create(:item, price: 100)
        
        # Act
        3.times { cart.add_item(i1.id) }
        2.times { cart.add_item(i2.id) }

        t = Time.local(2008, 4, 1, 10, 5, 0)
        Timecop.travel(t)
  
        # Assert
        expect(cart.total).to be 35.0
      end
    end




  describe "進階功能" do
    it "可以將購物車內容轉換成 Hash，存到 Session 裡" do 
      #Arrange 
      cart = Cart.new

      i1 = FactoryBot.create(:item)
      i2 = FactoryBot.create(:item)
      
      # Act
      3.times { cart.add_item(i1.id) }
      2.times { cart.add_item(i2.id) }

      # result = {
      #   "items" => [ #<<<"items"是一個key
      #     {"items_id" => 1, "quantity" => 3},
      #     {"items_id" => 2, "quantity" => 2}
      #   ]
      # }
      # Assert
      expect(cart.to_hash).to eq cart_hash
    end

    it "可以把 Session 的內容（Hash 格式），還原成購物車的內容" do
      #Acct 
      cart = Cart.from_hash(cart_hash)

      #Assert
      expect(cart.items.count).to be 2
    end
  end

  private
  #"items"是一個key
  def cart_hash
    {
    "items" => [ 
      {"item_id" => 1, "quantity" => 3},
      {"item_id" => 2, "quantity" => 2}
    ]
  }
  end
end
