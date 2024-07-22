# First admin create
User.create!(email: 'admin@test.com', password: 'Admin123!', name: 'Admin', admin: true) if Rails.env.development?

# Users create
user1 = User.create(name:'Vasia',email:'vasia@test.com',password:'User123!',phone:'+380000000000')
user2 = User.create(name:'Petro',email:'petro@test.com',password:'User123!',phone:'+380000000001')
user3 = User.create(name:'foma',email:'petro@example.com',password:'User123!',phone:'+380000000002')

# Cars create
Car.create(brand: 'Nissan', car_model: 'Micra', body: 'hatchback', mileage: 120, color: 'red',
          price: 4800, fuel: 'gas', year: 2013, volume: 1.2, user_id: user1.id)
Car.create(brand: 'MG', car_model: '4 EV', body: 'hatchback', mileage: 0, color: 'silver',
          price: 24500, fuel: 'electro', year: 2024, volume: 64, user_id: user2.id)

