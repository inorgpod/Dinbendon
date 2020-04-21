class Cart
  attr_reader :items
  def initialize(items = [])   #給一個預設值做空陣列 (((為何一定要用陣列？ 因為預設值是nil
    @items = items 
  end

  def add_item(item_id)
    found_item = @items.find{ |item|item.item_id == item_id }
  

    if found_item
      found_item.increment! #增加數量 ！驚嘆號就是對陣列內的物件作修改
    else
    @items << CartItem.new(item_id)  
    end
  end

  def empty?
    @items.empty?
  end

  def items 
    #return @items  ((return可省略
    @items
  end

  def total 
    result = @items.sum{ |item| item.total }

    if Time.now.month == 4 and Time.now.day == 1 
      result = result * 0.1
    end

    return result
    #@items.reduce(0) { |sum,item| sum + item.total } #reduce => 把陣列歸納相加的方法

    # tmp = 0 #給加法用預設值
    # @item.each do |item|
    #   tmp += item.total 
    # end
    # return tmp
  end

  def count
    @items.count #給一個實體變數讓這個運算可以跨到其他的view使用
  end

  def self.from_hash(hash = nil) #用類別方法 self.xxx
    if hash && hash["items"] #多家&& hash["items"] 是為了確保就算無回傳值也有作用
      # items = []

      # #   {"items_id" => 1, "quantity" => 3},
      # hash["items"].each do |item|
      #   items << CartItem.new( item["item_id"], item["quantity"]) #   << 雙左箭就是把值塞回陣列方法的意思

      item = hash["items"].map{ |item| 
        CartItem.new( item["item_id"], item["quantity"])
      }
      new(item)
    else 
      new
    end
  end

  def to_hash 
    # items = [ 
    #   {"items_id" => 1, "quantity" => 3},
    #   {"items_id" => 2, "quantity" => 2}
    # ]    <<<<<57-60行是items的陣列
    
    # items = []
    # @items.each do |item|
    #   items << {"item_id"  => item.item_id,
    #             "quantity" => item.quantity }
    #   end
    
    items = @items.map { |item| 
      {"item_id"  => item.item_id,"quantity" => item.quantity }
    
    }
    return {"items" => items }
  end
end