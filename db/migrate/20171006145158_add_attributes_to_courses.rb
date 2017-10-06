class AddAttributesToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :course_id, :string
    add_column :courses, :course_class, :string
    add_column :courses, :required, :string
    add_column :courses, :credit, :float
  end
end
