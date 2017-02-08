Fabricator(:user) do 
  email { Faker::Internet.email }
  password 'passpass'
  full_name { Faker::Name.name }
  admin false
  active true
end

Fabricator(:admin, from: :user) do
  admin true 
end
