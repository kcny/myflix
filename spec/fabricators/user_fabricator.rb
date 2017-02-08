Fabricator(:user) do 
  email { Faker::Internet.email }
  password 'passpass'
  full_name { Faker::Name.name }
  admin false
end

Fabricator(:admin, from: :user) do
  admin true 
end
