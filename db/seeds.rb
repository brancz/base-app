# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_role = Role.create(name: 'user')
admin_role = Role.create(name: 'admin')

user = User.new({email: 'test@example.com', password: 'test', password_confirmation: 'test'})
user.confirmation_sent_at = Time.now
user.roles << user_role
user.skip_confirmation!
user.save!(:validate => false)
