class CreateUserWords < ActiveRecord::Migration[5.1]
  def change
    create_table :user_words do |t|
      t.integer :user_id
      t.integer :word_id
      t.integer :answer_id
      t.boolean :status

      t.timestamps
    end
  end
end