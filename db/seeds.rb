require 'open-uri'
require 'csv'
require 'thread'

# ___________________Platform Admin___________________

admin = User.new({username: 'wvmitchell', email: 'wvmitchell@gmail.com', password: 'password'})
admin.admin = true
admin.save

admin2 = User.new({username: 'louisa', email: 'louisabarrett@gmail.com', password: 'password'})
admin2.admin = true
admin2.save

#___________________Roles_______________________

role_types = ['owner', 'stocker']
role_types.each do |role|
  Role.create(name: role)
end

#___________________cities_________________

cities = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ",
  "Philadelphia, PA", "San Antonio, TX", "San Diego, CA", "Dallas, TX", "San Jose, CA",
  "Detroit, MI", "San Francisco, CA", "Jacksonville, FL", "Indianapolis, IN", "Austin, TX",
  "Columbus, OH", "Fort Worth, TX", "Charlotte, NC", "Memphis, TN", "Boston, MA", "Baltimore, MD",
  "El Paso, TX", "Seattle, WA", "Denver, CO", "Nashville-Davidson, TN", "Milwaukee, WI", "Washington, DC",
  "Las Vegas, NV", "Louisville/Jefferson County, KY", "Portland, OR", "Oklahoma City, OK", "Tucson, AZ",
  "Atlanta, GA", "Albuquerque, NM", "Kansas City, MO", "Fresno, CA", "Mesa, AZ", "Sacramento, CA",
  "Long Beach, CA", "Omaha, NE", "Virginia Beach, VA", "Miami, FL", "Cleveland, OH", "Oakland, CA",
  "Raleigh, NC", "Colorado Springs, CO", "Tulsa, OK", "Minneapolis, MN", "Arlington, TX", "Honolulu, HI",
  "Wichita, KS"]

#___________________Restaurant Type 1__________________

    plates = Category.create(name: "Plates")
    snacks = Category.create(name: "Snacks")
    desserts = Category.create(name: "Dessert")
    soups = Category.create(name: "Soups")
    salads = Category.create(name: "Salads")
    sandwiches = Category.create(name: "Sandwiches")
    burgers = Category.create(name: "Burgers")
    brunch = Category.create(name: "Brunch")
    ["Entrees", "Appetizers", "Beverages", "Specialties",
        "Apéritifs", "Digestifs", "Vegetarian", "Kids Menu"].each do |cat|
        Category.create(name: cat)
    end



    user1 = User.create({username: "gerald0", email: "gerald0@example.com", password: 'password'})
    user2 = User.create({username: "gerald1", email: "gerald1@example.com", password: 'password'})
    user3 = User.create({username: "gerald2", email: "gerald2@example.com", password: 'password'})
    user4 = User.create({username: "gerald3", email: "gerald3@example.com", password: 'password'})
    owner = Role.find_by(name: 'owner')

    restaurant = Restaurant.create(name: "Platable", location: "123 Fake St", phone_number: "123-456-7890", region: cities.sample)
    restaurant.published = true
    restaurant.active = true


    restaurant.save
    Job.create_new(restaurant, user1, 'owner')
    Job.create_new(restaurant, user2, 'owner')
    Job.create_new(restaurant, user3, 'stocker')
    Job.create_new(restaurant, user4, 'stocker')


    deviled_eggs = Item.new(title: "Deviled Eggs", description: "12 delicious deviled eggs", price: '500', restaurant_id: restaurant.id)
    deviled_eggs.image = open("https://s3.amazonaws.com/fourth_meal/deviled_eggs.jpg")
    deviled_eggs.save

    snacks.items << deviled_eggs
    plates.items << deviled_eggs

    mac_and_cheese = Item.new(title: "Interstate Mac and Cheese", description: "Creamy Mac and Cheese", price: '500', restaurant_id: restaurant.id)
    mac_and_cheese.image = open("https://platable.s3.amazonaws.com/items/images/000/000/002/small/mac_and_cheese.jpg")
    mac_and_cheese.save

    snacks.items << mac_and_cheese

    spoon_bread = Item.new(title: "Spoon Bread", description: "Warm bread with butter, honey, and bacon", price: '700', restaurant_id: restaurant.id)
    spoon_bread.image = open("https://platable.s3.amazonaws.com/items/images/000/000/003/small/spoon_bread1.jpg")
    spoon_bread.save

    snacks.items << spoon_bread

    tomato_soup = Item.new(title: "Tomato Soup", description: "Roasted tomato soup with oozy grilled cheese", price: '600', restaurant_id: restaurant.id)
    tomato_soup.image = open("https://platable.s3.amazonaws.com/items/images/000/000/004/small/tomato_soup.jpg")
    tomato_soup.save

    soups.items << tomato_soup

    green_bean_salad = Item.new(title: "Green Bean Salad", description: "Fresh green beans with goat cheese and pecans", price: '800', restaurant_id: restaurant.id)
    green_bean_salad.image = open("https://platable.s3.amazonaws.com/items/images/000/000/005/small/green_beans.jpg")
    green_bean_salad.save

    salads.items << green_bean_salad

    arugula_salad = Item.new(title: "Arugula Salad", description: "Arugula, radish, and sunflower seeds with a zesty lemon vinaigrette", price: '700', restaurant_id: restaurant.id)
    arugula_salad.image = open("https://platable.s3.amazonaws.com/items/images/000/000/006/small/arugula_salad.jpg")
    arugula_salad.save

    salads.items << arugula_salad

    cubano_sandwich = Item.new(title: "Cubano Sandwich", description: "Classic cubano sandwich with house-made pickles, mustard, and black beans with rice", price: '900', restaurant_id: restaurant.id)
    cubano_sandwich.image = open("https://platable.s3.amazonaws.com/items/images/000/000/007/small/cubano_sandwich.jpg")
    cubano_sandwich.save

    sandwiches.items << cubano_sandwich

    monte_cristo = Item.new(title: "Monte Cristo Sandwich", description: "Classic Monte Cristo served with shoestring potatoes", price: '900', restaurant_id: restaurant.id)
    monte_cristo.image = open("https://platable.s3.amazonaws.com/items/images/000/000/008/small/monte_cristo.jpg")
    monte_cristo.save

    sandwiches.items << monte_cristo

    classic_burger = Item.new(title: "Classic Burger", description: "Burger and fries with your choice of swiss, cheddar, muenster, or provolone", price: '1000', restaurant_id: restaurant.id)
    classic_burger.image = open("https://platable.s3.amazonaws.com/items/images/000/000/009/small/classic_burger.jpg")
    classic_burger.save

    burgers.items << classic_burger

    veggie_burger = Item.new(title: "House Made Veggie Burger", description: "Burger and fries with your choice of swiss, cheddar, muenster, or provolone", price: '1000', restaurant_id: restaurant.id)
    veggie_burger.image = open("https://platable.s3.amazonaws.com/items/images/000/000/010/small/veggie_burger.jpg")
    veggie_burger.save

    burgers.items << veggie_burger

    chicken_fried_chicken = Item.new(title: "Chicken Fried Chicken", description: "Chicken fried chicken, pork belly green beans & country gravy", price: '1500', restaurant_id: restaurant.id)
    chicken_fried_chicken.image = open("https://platable.s3.amazonaws.com/items/images/000/000/011/small/chicken_fried_chicken.jpg")
    chicken_fried_chicken.save

    plates.items << chicken_fried_chicken

    seared_ribeye = Item.new(title: "Seared Ribeye", description: "Served with marinated roasted mushrooms", price: '1800', restaurant_id: restaurant.id)
    seared_ribeye.image = open("https://platable.s3.amazonaws.com/items/images/000/000/012/small/seared_ribeye.jpg")
    seared_ribeye.save

    plates.items << seared_ribeye

    tacos = Item.new(title: "New Mexican Veggie Street Tacos", description: "Accompanied by smoked mushrooms and roasted squash", price: '1900', restaurant_id: restaurant.id)
    tacos.image = open("https://platable.s3.amazonaws.com/items/images/000/000/013/small/tacos.jpg")
    tacos.save

    plates.items << tacos

    pork = Item.new(title: "Confit of Pork Porterhouse", description: "Served over a bed of polenta with braised greens", price: '1600', restaurant_id: restaurant.id)
    pork.image = open("https://platable.s3.amazonaws.com/items/images/000/000/014/small/pork.jpg")
    pork.save

    plates.items << pork

    grapefruit = Item.new(title: "Sugar Broiled Half Grapefruit", description: "Half a grapefruit topped with dark brown sugar and broiled until crisp", price: '400', restaurant_id: restaurant.id)
    grapefruit.image = open("https://platable.s3.amazonaws.com/items/images/000/000/015/small/grapefruit.jpg")
    grapefruit.save

    snacks.items << grapefruit
    brunch.items << grapefruit

    coffee_cake = Item.new(title: "Coffee Cake", description: "Walnut and brown sugar crumble coffee cake", price: '400', restaurant_id: restaurant.id)
    coffee_cake.image = open("https://platable.s3.amazonaws.com/items/images/000/000/016/small/coffee_cake.jpg")
    coffee_cake.save

    snacks.items << coffee_cake

    hoecakes = Item.new(title: "Sweet Corn Hoecake Platter", description: "Sweet corn hoecake, pulled pork, fried egg, house-made cheese curds, and hash",  price: '1000', restaurant_id: restaurant.id)
    hoecakes.image = open("https://platable.s3.amazonaws.com/items/images/000/000/017/small/hoecakes.jpg")
    hoecakes.save

    brunch.items << hoecakes
    plates.items << hoecakes

    french_toast = Item.new(title: "French Toast", description: "Topped with brûléed bananas, whipped cream, and maple syrup",  price: '800', restaurant_id: restaurant.id)
    french_toast.image = open("https://platable.s3.amazonaws.com/items/images/000/000/018/small/french_toast.jpg")
    french_toast.save

    brunch.items << french_toast
    plates.items << french_toast

    omelette = Item.new(title: "Freakin’ Denver Omelette", description: "Served with hash and toast",  price: '800', restaurant_id: restaurant.id)
    omelette.image = open("https://platable.s3.amazonaws.com/items/images/000/000/019/small/denver_omelette.jpg")
    omelette.save

    brunch.items << omelette
    plates.items << omelette

    trifle = Item.new(title: "Pecan & Mixed Berry Trifle", description: "Pecan and mixed berry trifle topped with whipped cream", price: '700', restaurant_id: restaurant.id)
    trifle.image = open("https://platable.s3.amazonaws.com/items/images/000/000/020/small/trifle.jpg")
    trifle.save

    desserts.items << trifle

    smores = Item.new(title: "Interstate S'Mores", description: "Graham crackers, marshmallows, and chocolate", price: '700', restaurant_id: restaurant.id)
    smores.image = open("https://platable.s3.amazonaws.com/items/images/000/000/021/small/s'mores.jpg")
    smores.save

    desserts.items << smores

    coco_cake = Item.new(title: "Coconut Cream Cheese Ice Box Cake", description: "Heaven on a plate", price: '700', restaurant_id: restaurant.id)
    coco_cake.image = open("https://platable.s3.amazonaws.com/items/images/000/000/022/small/coco_cake.jpg")
    coco_cake.save

    desserts.items << coco_cake


# _______________ WTPHO _______________________


    user5 = User.create({username: "gerome0", email: "gerome0@example.com", password: 'password'})
    user6 = User.create({username: "gerome1", email: "gerome1@example.com", password: 'password'})
    user7 = User.create({username: "gerome2", email: "gerome2@example.com", password: 'password'})
    user8 = User.create({username: "gerome3", email: "gerome3@example.com", password: 'password'})

    restaurant2 = Restaurant.create(name: "WTPHO", location: "456 Not Real Ave", phone_number: "456-123-7890", region: cities.sample)
    restaurant2.published = true
    restaurant2.active = true
    restaurant2.save
    images = File.open "./app/assets/images"

    restaurant2.save
    Job.create_new(restaurant2, user5, 'owner')
    Job.create_new(restaurant2, user6, 'owner')
    Job.create_new(restaurant2, user7, 'stocker')
    Job.create_new(restaurant2, user8, 'stocker')

    contents = CSV.open "./db/wtpho.csv", headers: true, header_converters: :symbol

    contents.each do |row|

      title       = row[:title]
      description = row[:description]
      price       = row[:price]
      category    = row[:category]
      image_file_name = row[:image_file_name]

      category_object = Category.find_or_create_by(name: category)
      item = restaurant2.items.create(title: title, description: description, price: price, image_file_name: image_file_name)

      ItemCategory.create(category_id: category_object.id, item_id: item.id)
    end
    category = Category.create(name: "House Specials")

    ItemCategory.create([{ item_id: 9, category_id: category.id},
                          { item_id: 10, category_id: category.id},
                          { item_id: 16, category_id: category.id},
                          { item_id: 12, category_id: category.id},
                          { item_id: 38, category_id: category.id}])

# _____________ workers __________________

  2.times do |n|

    Resque.enqueue(PlatableBuilder, n, cities.sample)

    Resque.enqueue(WtphoBuilder, n, cities.sample)


  end
