# User
User.create!(name: "nodopou公式",
             account_id: "nodopou_official",
             email: "info@nodopou.com",
             password: "foobar",
             password_confirmation: "foobar",
             remote_image_url: Faker::Avatar.image,
             profile: "nodopou公式アカウントです。",
             admin: true)

if Rails.env.development?
  User.create!(name: "masa",
               account_id: "masa",
               email: "masa@example.com",
               password: "foobar",
               password_confirmation: "foobar",
               remote_image_url: Faker::Avatar.image,
               profile: "テストアカウント")

  5.times do |n|
    name = "nodopou_#{n+3}"
    account_id = "nodopou_#{n+3}"
    email = "nodopou_#{n+3}@example.com"
    password = "password"
    image = Faker::Avatar.image
    profile = Faker::Lorem.sentence(5)
    User.create!(name: name,
                 account_id: account_id,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 remote_image_url: image,
                 profile: profile)
  end
end

#List
if Rails.env.development?
  users = User.order(:created_at).take(3)
  m = 0
  5.times do
    users.each do |user|
      list = user.create_lists.create!(content: "テスト-#{m}")
      user.avail(list)
      m += 1
    end
  end
end

#Mylist
if Rails.env.development?
  users = User.all
  lists = List.all
  availings = users[3..6]
  4.times do
    availings.each do |user|
      while true
        list = lists[rand(lists.length)]
        unless user.availing?(list)
          user.avail(list)
          break
        end
      end
    end
  end
end