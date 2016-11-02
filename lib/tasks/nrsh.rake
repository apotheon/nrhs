namespace :nrhs do
  desc 'Create Admin User'
  task :create_admin, [:email, :password] => :environment do |t, args|
    User.create(
      email: args[:email],
      password: args[:password],
      password_confirmation: args[:password],
      admin: true
    )
  end
end
