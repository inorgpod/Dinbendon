FactoryBot.define do
  factory :category do
    name { Faker::Name.name } #block
  end
end

# c0 = Category.new(name: "Category 123")
# puts c0.name => "Category 123"

# c1 = FactoryBot.creat(:category)
# puts c1.name => "Category 123"