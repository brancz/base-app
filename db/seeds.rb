# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Add default role"
user_role = Role.create(name: 'User', internal_name: 'user')
puts "Add admin role"
admin_role = Role.create(name: 'Admin', internal_name: 'admin')

if Rails.env.development?
  puts "Add development user"
  user = User.new({email: 'test@example.com', password: 'test', password_confirmation: 'test'})
  user.confirmation_sent_at = Time.now
  user.skip_confirmation!
  user.save!(:validate => false)

  25.times do |i|
    puts "Add development user"
    user = User.new({email: "test#{i}@example.com", password: 'test', password_confirmation: 'test'})
    user.confirmation_sent_at = Time.now
    user.skip_confirmation!
    user.save!(:validate => false)
  end
end

puts "Add development admin"
user = User.new({email: 'admin@example.com', password: 'test', password_confirmation: 'test'})
user.confirmation_sent_at = Time.now
user.roles << admin_role
user.skip_confirmation!
user.save!(:validate => false)
