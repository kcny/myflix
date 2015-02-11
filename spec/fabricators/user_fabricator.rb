Fabricator(:user) do 
  email { Faker::Internet.email }
  password 'passpass'
  full_name { Faker::Name.name }
end
