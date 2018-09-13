class ChangeUserIdTypoToAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :uesr_id 
    add_column :answers, :user_id, :integer
  end
end
