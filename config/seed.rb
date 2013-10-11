
unless User.first(email: 'admin@fake.tld')
  User.new(email: 'admin@fake.tld', password: 'password', password_confirmation: 'password').save
end
