class AddAdmin < ActiveRecord::Migration[7.0]
  def change
    User.create! do |u|
      u.email = 'admin@a.com'
      u.password = '123456'
      u.admin = true
    end
  end
end
