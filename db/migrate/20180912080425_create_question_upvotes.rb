class CreateQuestionUpvotes < ActiveRecord::Migration[5.1]
  def change
    create_table :question_upvotes do |t|

      t.timestamps
    end
  end
end
