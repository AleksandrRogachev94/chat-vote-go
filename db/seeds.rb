# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(nickname: "Alex", email: "alex@gmail.com", password: "123", password_confirmation: "123", first_name: "Alex", last_name: "Rogachev")
User.create(nickname: "Ksu", email: "ksu@gmail.com", password: "123", password_confirmation: "123", first_name: "Kseniia", last_name: "Gromova")
User.create(nickname: "Luda", email: "luda@gmail.com", password: "123", password_confirmation: "123", first_name: "Ludmila", last_name: "Rubtsova")

Chatroom.create(owner: User.first, title: "Hey lets go to a cinema tonight")

UserChatroom.create(chatroom: Chatroom.first, user: User.all[1])
UserChatroom.create(chatroom: Chatroom.first, user: User.all[2])

Message.create(chatroom: Chatroom.first, user: User.all[0], content: "What do you think?")
Message.create(chatroom: Chatroom.first, user: User.all[1], content: "Sure!")

Chatroom.create(owner: User.all[1], title: "Choosing theater for friday")

UserChatroom.create(chatroom: Chatroom.last, user: User.all[0])
UserChatroom.create(chatroom: Chatroom.last, user: User.all[2])

Message.create(chatroom: Chatroom.last, user: User.all[1], content: "Hey guys how are you?")
Message.create(chatroom: Chatroom.last, user: User.all[0], content: "Good! You?")
