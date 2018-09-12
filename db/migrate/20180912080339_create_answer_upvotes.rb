class CreateAnswerUpvotes < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_upvotes do |t|

      t.timestamps
    end
  end
end
