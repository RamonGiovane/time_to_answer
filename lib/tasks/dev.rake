namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "TODO"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping db...") { %x(rails db:drop) }
      show_spinner("Recreating db...") { %x(rails db:create) }
      show_spinner("Migrating db...") { %x(rails db:migrate) }
      show_spinner("Creating default profiles...") { %x(rails dev:add_default_profiles) }
    
    else
      puts "You're not in development environment!"
    end
  end


  task add_default_profiles: :environment do
    if Rails.env.development?
      Admin.create!(email: 'admin@teste.com.br', password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD)
      User.create!(email: 'user@teste.com.br', password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD)
    else
      puts "You're not in development environment!"
    end
  end


  private

  def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
    
  end 

end
