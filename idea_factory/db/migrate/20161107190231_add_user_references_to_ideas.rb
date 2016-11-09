class AddUserReferencesToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_reference :ideas, :user, foreign_key: true, index: true
  end
end
