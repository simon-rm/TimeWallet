class CreateUsersAndDays < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :guest_token

      t.timestamps
    end

    create_table :days do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :work_seconds, default: 0
      t.integer :life_seconds, default: 0
      t.integer :current_mode, default: 0
      t.datetime :ended_at
      t.timestamps
    end
  end
end
