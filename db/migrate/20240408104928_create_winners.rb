class CreateWinners < ActiveRecord::Migration[7.1]
  def change
    create_table :winners do |t|
      t.references :user, null: false, foreign_key: true
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.integer :distance, null: false
      t.boolean :email_sent, default: false

      t.timestamps
    end
  end
end
