class CreatePensionSummaries < ActiveRecord::Migration[5.1]
  def change
    # Required for uuid auto-generated ids
    enable_extension 'pgcrypto'

    create_table :pension_summaries, id: :uuid do |t|
      # Primary options
      t.boolean :leave_your_pot_untouched, null: false, default: false
      t.boolean :get_a_guaranteed_income, null: false, default: false
      t.boolean :get_an_adjustable_income, null: false, default: false
      t.boolean :take_cash, null: false, default: false
      t.boolean :take_whole, null: false, default: false
      t.boolean :mix_your_options, null: false, default: false

      # Secondary options
      t.boolean :how_my_pension_affects_my_benefits, null: false, default: false
      t.boolean :getting_help_with_debt, null: false, default: false
      t.boolean :taking_my_pension_if_im_ill, null: false, default: false
      t.boolean :transferring_my_pension_to_another_provider, null: false, default: false

      # Compulsory options
      t.boolean :scams, null: false, default: true
      t.boolean :how_my_pension_is_taxed, null: false, default: true

      # Implicit steps
      t.boolean :final, null: false, default: true

      t.datetime :generated_at
      t.timestamps null: false
    end
  end
end
