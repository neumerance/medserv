namespace :app do
  desc "Nuking app"
  task nuke: :environment do
    puts "Nuking the app now"
    Client.all.destroy_all
    User.all.destroy_all
    puts "All records has been annihilated"
  end
end
