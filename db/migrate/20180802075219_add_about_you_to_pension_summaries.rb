class AddAboutYouToPensionSummaries < ActiveRecord::Migration[5.1]
  def change
    change_table :pension_summaries do |t|
      t.column :pilot, :boolean, null: false, default: false
      t.column :gender, :string, limit: 30
      t.column :age, :string, limit: 30
      t.column :defined_contribution, :boolean
      t.column :defined_benefit, :boolean
      t.column :uncertain, :boolean
    end
  end
end
