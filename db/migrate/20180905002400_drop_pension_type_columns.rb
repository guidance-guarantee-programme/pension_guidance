class DropPensionTypeColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :pension_summaries, :defined_contribution, :boolean
    remove_column :pension_summaries, :defined_benefit, :boolean
    remove_column :pension_summaries, :uncertain, :boolean
  end
end
