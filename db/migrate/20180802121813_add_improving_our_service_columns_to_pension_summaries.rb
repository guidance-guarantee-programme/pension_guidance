class AddImprovingOurServiceColumnsToPensionSummaries < ActiveRecord::Migration[5.1]
  def change
    change_table :pension_summaries do |t|
      t.column :consent_given, :boolean, null: false, default: false
      t.column :name, :string, limit: 100
      t.column :email, :string, limit: 100
      t.column :country, :string, limit: 50
      t.column :satisfaction, :integer
      t.column :comments, :text
      t.column :where_you_heard, :integer
      t.column :submitted_at, :datetime
    end
  end
end
