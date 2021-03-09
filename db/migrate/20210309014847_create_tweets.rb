class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :post
      t.integer :userid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
