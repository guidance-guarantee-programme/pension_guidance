class CreatePensionSummaryStepViewings < ActiveRecord::Migration[5.1]
  def change
    create_table :pension_summary_step_viewings do |t|
      t.belongs_to :pension_summary, type: :uuid, index: true, foreign_key: true
      t.string     :step, limit: 100, null: false
      t.datetime   :created_at, null: false
    end
  end
end
