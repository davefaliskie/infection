class CreateCoachStudents < ActiveRecord::Migration
  def change
    create_table :coach_students do |t|
    	t.integer :user_id
    	t.integer :student_id
      t.timestamps
    end

    add_index :coach_students, [:user_id, :student_id]
  end
end
