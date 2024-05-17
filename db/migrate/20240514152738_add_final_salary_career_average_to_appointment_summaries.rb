class AddFinalSalaryCareerAverageToAppointmentSummaries < ActiveRecord::Migration[6.1]
  def change
    add_column :pension_summaries, :final_salary_career_average, :boolean, null: false, default: false
  end
end
