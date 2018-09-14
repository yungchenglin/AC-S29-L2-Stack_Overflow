class ChangeVotesCountToUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :votes_count
    add_column :users, :question_votes_count, :integer
    add_column :users, :answer_votes_count, :integer
  end
end
