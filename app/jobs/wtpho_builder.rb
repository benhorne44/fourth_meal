require 'csv'

class WtphoBuilder

  @queue = :restaurants

  def self.perform(number, city)
 # _______ WTPHO ____________________
    n = number

    user5 = User.create({username: "bobby#{n}", email: "bobby#{n}@example.com", password: 'password'})
    user6 = User.create({username: "bobby#{n}", email: "bobby#{n}@example.com", password: 'password'})
    user7 = User.create({username: "ricky#{n}", email: "ricky#{n}@example.com", password: 'password'})
    user8 = User.create({username: "ricky#{n}", email: "ricky#{n}@example.com", password: 'password'})

    restaurant2 = Restaurant.create(name: "WTPHO+#{n}", location: "456 Not Real Ave", phone_number: "456-123-7890", region: city)
    restaurant2.published = true
    restaurant2.active = true
    restaurant2.save

    restaurant2.save
    Job.create_new(restaurant2, user5, 'owner')
    Job.create_new(restaurant2, user6, 'owner')

    spring_rolls = restaurant2.items.create(title: "Spring Rolls with Shrimp & Pork",
                             description: "Shrimp, pork, rice noodels, lettuce, and herbs are wrapped in a rice paper and server with peanut or fish sauce.  Other combinations available.",
                             price: 395,
                             image_file_name: "spring-rolls-with-shrimp.jpg")

    Category.all.sample(2).each {|cat| cat.items << spring_rolls }

    Category.all.sample.items << restaurant2.items.create(title: "Vietnamese Egg Roll",
                             description:     "Shrimp, pork, vermicelli noodles, lettuce and herbs are wrapped in a rice paper and served with peanut sauce or fish sauce.",
                             price: 695,
                             image_file_name: "vietnamese-egg-roll.jpg")

    Category.all.sample.items << restaurant2.items.create(title: "Shrimp and Coconut Milk",
                             description:     "Battered shrimp fried to perfection topped with a creamy coconut milk sauce.",
                             price: 695,
                             image_file_name: "shrimp-and-coconut-milk.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "BBQ Short Ribs",
                             description:     "Ribs slowly grilled and topped with Spring Onions.",
                             price: 795,
                             image_file_name: "bbq-short-ribs.jpg")
    lamb = restaurant2.items.create(title: "Slowly Grilled Lamb Chop Platter",
                             description:     "Slowly Grilled Lamb Chops topped with onions and served with curry peanut sauce.",
                             price: 1095,
                             image_file_name: "slowly-grilled-lamb-chop-platter.jpg")

    Category.all.sample(2).each {|cat| cat.items << lamb }

    Category.all.sample.items << restaurant2.items.create(title: "Soft Shell Crab with Vegetables",
                             description:     "Fried soft shell crab served with vegetables.",
                             price: 1595,
                             image_file_name: "soft-shell-crab-with-vegetables.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "Pho 95 Special",
                             description:     "Grilled beef, pork, chicken, fried soft shell crab and vegetables served with rice paper.",
                             price: 2295,
                             image_file_name: "pho-95-special.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "House Special Lambchop Plate",
                             description:     "Slow grilled lamb chops topped with Spring Onions and served with curry peanut sauce.",
                             price: 1795,
                             image_file_name: "house-special-lambchop-plate.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "House Special Lambchop Plate",
                             description:     "Slow grilled lamb chops topped with Spring Onions and served with curry peanut sauce.",
                             price: 1795,
                             image_file_name: "house-special-lambchop-plate.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "Wild Salmon House Special",
                             description:     "Fresh Wild Salmon marinated with ginger and topped with grean leaf lettuce and tomatoes. Served with sesame soy sauce, green beans and radish.",
                             price: 1695,
                             image_file_name: "wild-salmon-house-special.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "Deep-Fried Banana",
                             description:     "Fresh bananas deep-fried in a light batter topped with chocolate sauce and powdered sugar.",
                             price: 695,
                             image_file_name: "deep-fried-bananna.jpg")

    fried_banana = restaurant2.items.create(title: "Fried Banana with Coconut Milk and Sesame.",
                             description:     "Fried Ice Cream topped with coconut milk and sesame seeds.",
                             price: 595,
                             image_file_name: "fried-banana-with-coconut-milk-and-sesame.jpg")

    Category.all.sample(2).each {|cat| cat.items << fried_banana }

    Category.all.sample.items << restaurant2.items.create(title: "Fried Ice Cream",
                             description:     "Fried Ice Cream (Strawberry or Green Tea.)",
                             price: 795,
                             image_file_name: "fried-ice-cream.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "Thai Fruit Cocktail",
                             description:     "A delcious fruit cocktail.",
                             price: 395,
                             image_file_name: "thai-fruit-cocktail.jpg")
    Category.all.sample.items << restaurant2.items.create(title: "Vietnamese Coffee",
                             description:     "Vietnamese coffee served with a glass of ice.",
                             price: 345,
                             image_file_name: "vietnamese-coffee.jpg")
    pho_soup = restaurant2.items.create(title: "Pho Soup Combination",
                             description:     "Well-done brisket, flank, tendon & tripe in our signature beef broth with noodles and medoly of vegetables and herbs.",
                             price: 895,
                             image_file_name: "pho-soup-combination.jpg")

    Category.all.sample(2).each {|cat| cat.items << pho_soup }

    Category.all.sample.items << restaurant2.items.create(title: "Kids Pho Soup",
                             description:     "Choose from a variety of different pho-soup combinations to fit your childs needs; Chicken, rare steak, meatball or plain.",
                             price: 375,
                             image_file_name: "kids-pho-soup.jpg")


  end
end
