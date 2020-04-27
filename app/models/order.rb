class Order < ApplicationRecord
  attr_reader :nonce #只是給一個屬性 避開no method的錯誤訊息
  belongs_to :user
  has_many :order_items

  before_create :create_order_num


  aasm column: 'state' do
    state :pending, initial: true
    state :paid, :delivered , :cancelled

    event :pay do
      transitions from: :pending, to: :paid
      after_transaction do 
        puts "-" *10
        puts "發簡訊" 
        puts "-" *10
      end
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end

    event :pending do
      transitions from: [:running, :cleaning], to: :sleeping
    end
  end


  private 

  def create_order_num
    self.order_num = num_generator  #num 用self callbacks 看文件
    
  end

  def num_generator
    year  = Date.today.year
    month = Date.today.month
    today = Date.today.day
    code = [*0..9,*'A'..'Z'].sample(6).join

    "#{year}#{"%02d" %month}#{"%02d"%day}"  #?????? #字號是？%02d ??? 看文件DATE部分

  end

end
