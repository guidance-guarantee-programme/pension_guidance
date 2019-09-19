class CreateReferrals < ActiveRecord::Migration[5.2]
  def change
    create_table :referrals do |t|
      t.string :agent_identifier, null: false, index: true
      t.string :pension_provider, null: false, default: ''
      t.string :surname, null: false, default: ''
      t.string :call_outcome, null: false, default: ''
      t.date :date_of_birth, null: false

      t.timestamps null: false
    end
  end
end
