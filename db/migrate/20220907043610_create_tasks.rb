class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string  :description, null: false
      t.boolean :done,        null: false, default: false
      t.date    :due_date,    null: true

      t.timestamps
    end
  end
end
