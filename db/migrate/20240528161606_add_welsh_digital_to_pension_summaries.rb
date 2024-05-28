class AddWelshDigitalToPensionSummaries < ActiveRecord::Migration[6.1]
  def change
    add_column :pension_summaries, :welsh_digital, :boolean, default: false, null: false
  end
end
