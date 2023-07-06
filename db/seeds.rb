# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(name: 'iqbal', email: 'iqbal@gmail.com', password: '123456')
user2 = User.create(name: 'bahir', email: 'bahir@gmail.com', password: '123456')

recipe1 = Recipe.create(name: 'pizza', preparation_time: '20 minutes', cooking_time: '25 minutes',
                        description: 'cook it in oven', public: true, user_id: user1.id)
recipe2 = Recipe.create(name: 'kabab', preparation_time: '15 minutes', cooking_time: '10 minutes',
                        description: 'cook it on coal', public: false, user_id: user2.id)

Food.create(name: 'Apple', measurement_unit: 'grams', price: 5, quantity: 1, user_id: user2.id)
Food.create(name: 'Pineapple', measurement_unit: 'grams', price: 1, quantity: 1, user_id: user2.id)
Food.create(name: 'Chicken breasts', measurement_unit: 'units', price: 2, quantity: 1, user_id: user1.id)
