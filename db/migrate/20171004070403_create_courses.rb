class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :teacher
      t.string :time
      t.string :place
      t.integer :volume
      t.integer :now_selected

      t.timestamps
    end
  end
end
