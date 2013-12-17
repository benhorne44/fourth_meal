class PlatableBuilder

  @queue = :restaurants

  def self.perform(number)
    n = number
    user1 = User.create({username: "bob#{n}", email: "bob#{n}@example.com", password: 'password'})
    user2 = User.create({username: "bob#{n}", email: "bob#{n}@example.com", password: 'password'})
    user3 = User.create({username: "rick#{n}", email: "rick#{n}@example.com", password: 'password'})
    user4 = User.create({username: "rick#{n}", email: "rick#{n}@example.com", password: 'password'})
    owner = Role.find_by(name: 'owner')
    restaurant = Restaurant.create(name: "Platable+#{number}", location: "123 Fake St", phone_number: "123-456-7890", region: city)
    restaurant.published = true
    restaurant.active = true
    restaurant.jobs.create(user_id: user1.id, role_id: owner.id)
    restaurant.jobs.create(user_id: user2.id, role_id: owner.id)

    restaurant.save
    Job.create_new(restaurant, user1, 'owner')
    Job.create_new(restaurant, user2, 'owner')
    Job.create_new(restaurant, user3, 'stocker')
    Job.create_new(restaurant, user4, 'stocker')


    deviled_eggs = Item.new(title: "Deviled Eggs", description: "12 delicious deviled eggs", price: '500', restaurant_id: restaurant.id)
    deviled_eggs.image = open("https://s3.amazonaws.com/fourth_meal/deviled_eggs.jpg")
    deviled_eggs.save

    Category.all.sample(2).each { |cat| cat.items << deviled_eggs }

    mac_and_cheese = Item.new(title: "Interstate Mac and Cheese", description: "Creamy Mac and Cheese", price: '500', restaurant_id: restaurant.id)
    mac_and_cheese.image = open("https://platable.s3.amazonaws.com/items/images/000/000/002/small/mac_and_cheese.jpg")
    mac_and_cheese.save

    Category.all.sample.items << mac_and_cheese

    spoon_bread = Item.new(title: "Spoon Bread", description: "Warm bread with butter, honey, and bacon", price: '700', restaurant_id: restaurant.id)
    spoon_bread.image = open("https://platable.s3.amazonaws.com/items/images/000/000/003/small/spoon_bread1.jpg")
    spoon_bread.save

    Category.all.sample.items << spoon_bread

    tomato_soup = Item.new(title: "Tomato Soup", description: "Roasted tomato soup with oozy grilled cheese", price: '600', restaurant_id: restaurant.id)
    tomato_soup.image = open("https://platable.s3.amazonaws.com/items/images/000/000/004/small/tomato_soup.jpg")
    tomato_soup.save

    Category.all.sample.items << tomato_soup

    green_bean_salad = Item.new(title: "Green Bean Salad", description: "Fresh green beans with goat cheese and pecans", price: '800', restaurant_id: restaurant.id)
    green_bean_salad.image = open("https://platable.s3.amazonaws.com/items/images/000/000/005/small/green_beans.jpg")
    green_bean_salad.save

    Category.all.sample.items << green_bean_salad

    arugula_salad = Item.new(title: "Arugula Salad", description: "Arugula, radish, and sunflower seeds with a zesty lemon vinaigrette", price: '700', restaurant_id: restaurant.id)
    arugula_salad.image = open("https://platable.s3.amazonaws.com/items/images/000/000/006/small/arugula_salad.jpg")
    arugula_salad.save

    Category.all.sample.items << arugula_salad

    cubano_sandwich = Item.new(title: "Cubano Sandwich", description: "Classic cubano sandwich with house-made pickles, mustard, and black beans with rice", price: '900', restaurant_id: restaurant.id)
    cubano_sandwich.image = open("https://platable.s3.amazonaws.com/items/images/000/000/007/small/cubano_sandwich.jpg")
    cubano_sandwich.save

    Category.all.sample.items << cubano_sandwich

    monte_cristo = Item.new(title: "Monte Cristo Sandwich", description: "Classic Monte Cristo served with shoestring potatoes", price: '900', restaurant_id: restaurant.id)
    monte_cristo.image = open("https://platable.s3.amazonaws.com/items/images/000/000/008/small/monte_cristo.jpg")
    monte_cristo.save

    Category.all.sample.items << monte_cristo

    classic_burger = Item.new(title: "Classic Burger", description: "Burger and fries with your choice of swiss, cheddar, muenster, or provolone", price: '1000', restaurant_id: restaurant.id)
    classic_burger.image = open("https://platable.s3.amazonaws.com/items/images/000/000/009/small/classic_burger.jpg")
    classic_burger.save

    Category.all.sample.items << classic_burger

    veggie_burger = Item.new(title: "House Made Veggie Burger", description: "Burger and fries with your choice of swiss, cheddar, muenster, or provolone", price: '1000', restaurant_id: restaurant.id)
    veggie_burger.image = open("https://platable.s3.amazonaws.com/items/images/000/000/010/small/veggie_burger.jpg")
    veggie_burger.save

    Category.all.sample.items << veggie_burger

    chicken_fried_chicken = Item.new(title: "Chicken Fried Chicken", description: "Chicken fried chicken, pork belly green beans & country gravy", price: '1500', restaurant_id: restaurant.id)
    chicken_fried_chicken.image = open("https://platable.s3.amazonaws.com/items/images/000/000/011/small/chicken_fried_chicken.jpg")
    chicken_fried_chicken.save

    Category.all.sample.items << chicken_fried_chicken

    seared_ribeye = Item.new(title: "Seared Ribeye", description: "Served with marinated roasted mushrooms", price: '1800', restaurant_id: restaurant.id)
    seared_ribeye.image = open("https://platable.s3.amazonaws.com/items/images/000/000/012/small/seared_ribeye.jpg")
    seared_ribeye.save

    Category.all.sample.items << seared_ribeye

    tacos = Item.new(title: "New Mexican Veggie Street Tacos", description: "Accompanied by smoked mushrooms and roasted squash", price: '1900', restaurant_id: restaurant.id)
    tacos.image = open("https://platable.s3.amazonaws.com/items/images/000/000/013/small/tacos.jpg")
    tacos.save

    Category.all.sample.items << tacos

    pork = Item.new(title: "Confit of Pork Porterhouse", description: "Served over a bed of polenta with braised greens", price: '1600', restaurant_id: restaurant.id)
    pork.image = open("https://platable.s3.amazonaws.com/items/images/000/000/014/small/pork.jpg")
    pork.save

    Category.all.sample.items << pork

    grapefruit = Item.new(title: "Sugar Broiled Half Grapefruit", description: "Half a grapefruit topped with dark brown sugar and broiled until crisp", price: '400', restaurant_id: restaurant.id)
    grapefruit.image = open("https://platable.s3.amazonaws.com/items/images/000/000/015/small/grapefruit.jpg")
    grapefruit.save

    Category.all.sample(2).each { |cat| cat.items << grapefruit }

    coffee_cake = Item.new(title: "Coffee Cake", description: "Walnut and brown sugar crumble coffee cake", price: '400', restaurant_id: restaurant.id)
    coffee_cake.image = open("https://platable.s3.amazonaws.com/items/images/000/000/016/small/coffee_cake.jpg")
    coffee_cake.save

    Category.all.sample.items << coffee_cake

    hoecakes = Item.new(title: "Sweet Corn Hoecake Platter", description: "Sweet corn hoecake, pulled pork, fried egg, house-made cheese curds, and hash",  price: '1000', restaurant_id: restaurant.id)
    hoecakes.image = open("https://platable.s3.amazonaws.com/items/images/000/000/017/small/hoecakes.jpg")
    hoecakes.save

    Category.all.sample(2).each { |cat| cat.items << hoecakes }

    french_toast = Item.new(title: "French Toast", description: "Topped with brûléed bananas, whipped cream, and maple syrup",  price: '800', restaurant_id: restaurant.id)
    french_toast.image = open("https://platable.s3.amazonaws.com/items/images/000/000/018/small/french_toast.jpg")
    french_toast.save

    Category.all.sample(2).each { |cat| cat.items << french_toast }

    omelette = Item.new(title: "Freakin’ Denver Omelette", description: "Served with hash and toast",  price: '800', restaurant_id: restaurant.id)
    omelette.image = open("https://platable.s3.amazonaws.com/items/images/000/000/019/small/denver_omelette.jpg")
    omelette.save

    Category.all.sample(2).each { |cat| cat.items << omelette }

    trifle = Item.new(title: "Pecan & Mixed Berry Trifle", description: "Pecan and mixed berry trifle topped with whipped cream", price: '700', restaurant_id: restaurant.id)
    trifle.image = open("https://platable.s3.amazonaws.com/items/images/000/000/020/small/trifle.jpg")
    trifle.save

    Category.all.sample.items << trifle

    smores = Item.new(title: "Interstate S'Mores", description: "Graham crackers, marshmallows, and chocolate", price: '700', restaurant_id: restaurant.id)
    smores.image = open("https://platable.s3.amazonaws.com/items/images/000/000/021/small/s'mores.jpg")
    smores.save

    Category.all.sample.items << smores

    coco_cake = Item.new(title: "Coconut Cream Cheese Ice Box Cake", description: "Heaven on a plate", price: '700', restaurant_id: restaurant.id)
    coco_cake.image = open("https://platable.s3.amazonaws.com/items/images/000/000/022/small/coco_cake.jpg")
    coco_cake.save

    Category.all.sample.items << coco_cake


  end

end
