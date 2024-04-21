class AddUserIdToAdmin < ActiveRecord::Migration[7.1]
  def change
    add_reference :admins, :user, null: false, foreign_key: true
  end
end
