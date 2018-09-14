class ModifyQuestionIdTypoToQuestionUpvote < ActiveRecord::Migration[5.1]
  def change
    remove_column :question_upvotes, :answer_id
    add_column :question_upvotes, :question_id, :integer
  end
end
