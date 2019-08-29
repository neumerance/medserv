namespace :admin do
  task :create_admin => [:environment] do
    puts "Creating admint account"
    user = User.create(
      email: 'admin@untvsg.com',
      password: 'ABC12abc',
      password_confirmation: 'ABC12abc',
      name: 'UNTV admin'
    )
    puts 'Admina account: admin@untvsg.com:ABC12abc, please change password immediately'
  end
end
