class CreateUsersDaysAndTimers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :guest_token

      t.timestamps
    end

    create_table :days do |t|
      t.belongs_to :user, null: true
      t.datetime :finished_at
      t.timestamps
    end

    create_table :timers do |t|
      t.belongs_to :day, null: true
      t.string :name
      t.integer :duration, default: 0
      t.integer :expected_duration
      t.datetime :running_since
    end
  end
end
