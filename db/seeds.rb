class Seed
  attr_reader :admin_username,
              :admin_password,
              :user_username,
              :user_password

  def initialize
    @admin_username = ENV["admin_username"]
    @admin_password = ENV["admin_password"]
    @user_username  = ENV["user_username"]
    @user_password  = ENV["admin_password"]
  end

  def self.start
    seed = Seed.new
    seed.create_admin
    seed.create_user
    puts "Seed Complete"
  end

  def create_admin
    admin                       = User.new
    admin.email                 = admin_username
    admin.password              = admin_password
    admin.password_confirmation = admin_password
    admin.role                  = 1
    admin.save
    puts "Admin Created"
  end

  def create_user
    user                       = User.new
    user.email                 = user_username
    user.password              = user_password
    user.password_confirmation = user_password
    user.save
    puts "User Created"
  end
end
Seed.start
