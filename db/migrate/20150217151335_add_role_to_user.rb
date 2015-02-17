class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'user'
    kyle = User.find(1)
    kyle.role = 'admin'
    kyle.save!
  end
end
