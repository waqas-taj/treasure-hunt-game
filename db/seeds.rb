# Seed data for users
User.create!(
  name: 'Admin',
  email: 'test@test.com',
  password: 'test123'
)

# Seed data for winners
Winner.create!(
  user_id: User.first.id,
  latitude: 40.7128,
  longitude: -74.0060,
  distance: 10
)

puts 'Records Created Successfully.'
