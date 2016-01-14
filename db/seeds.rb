# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Khong Minh Tri",
  email: "khong.minh.tri@framgia.com",
  password: "123456",
  password_confirmation: "123456",
  activated: true,
  activated_at: Time.zone.now)

linh2 = Superuser.create(name:"linh2",email:"linh2@gmail.com",
  password:"linhtn",password_confirmation:"linhtn")
