require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  test "item invalid without title" do
    item = Item.new({description: 'tasty', price: '3'})
    refute item.save
  end

  test "item invalid without description" do
    item = Item.new({title: 'tasty', price: '3'})
    refute item.save
  end

  test "item invalid without price" do
    item = Item.new({title: 'tasty', description: '3'})
    refute item.save
  end

  test "class method active returns active items" do
    Item.create({title: 'tasty', description: '3', price:'bread'})
    Item.create({title: 'smelly', description: '5', price:'3', active: false})

    assert_equal 1, Item.active.count
  end

  test "can attach image when editing" do
    @item = Item.new({title: 'eggs', description: 'tasty', price: '3'})
    @item.image = File.new("test/fixtures/deviled_eggs.jpg")
    @item.save
    assert_equal @item.image_file_name, "deviled_eggs.jpg"
  end

  test "cannot add duplicate categories" do
    item = Item.create({title: 'eggs', description: 'tasty', price: '3'})
    category1 = Category.create({name: "Fruit"})
    category2 = Category.create({name: "Vegetable"})
    item.categories << category1
    item.categories << category2
    item.categories << category1
    assert_equal 2, item.categories.count
    refute_equal item.categories.first, item.categories.last
  end

end
