# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[6.1].define(version: 2024_05_28_161606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "pension_summaries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "leave_your_pot_untouched", default: false, null: false
    t.boolean "get_a_guaranteed_income", default: false, null: false
    t.boolean "get_an_adjustable_income", default: false, null: false
    t.boolean "take_cash", default: false, null: false
    t.boolean "take_whole", default: false, null: false
    t.boolean "mix_your_options", default: false, null: false
    t.boolean "how_my_pension_affects_my_benefits", default: false, null: false
    t.boolean "getting_help_with_debt", default: false, null: false
    t.boolean "taking_my_pension_if_im_ill", default: false, null: false
    t.boolean "transferring_my_pension_to_another_provider", default: false, null: false
    t.boolean "scams", default: true, null: false
    t.boolean "how_my_pension_is_taxed", default: true, null: false
    t.boolean "final", default: true, null: false
    t.datetime "generated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pilot", default: false, null: false
    t.string "gender", limit: 30
    t.string "age", limit: 30
    t.boolean "consent_given", default: false, null: false
    t.string "name", limit: 100
    t.string "email", limit: 100
    t.string "country", limit: 50
    t.integer "satisfaction"
    t.text "comments"
    t.integer "where_you_heard"
    t.datetime "submitted_at"
    t.boolean "final_salary_career_average", default: false, null: false
    t.boolean "welsh_digital", default: false, null: false
  end

  create_table "pension_summary_step_viewings", force: :cascade do |t|
    t.uuid "pension_summary_id"
    t.string "step", limit: 100, null: false
    t.datetime "created_at", null: false
    t.index ["pension_summary_id"], name: "index_pension_summary_step_viewings_on_pension_summary_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.string "agent_identifier", null: false
    t.string "pension_provider", default: "", null: false
    t.string "surname", default: "", null: false
    t.string "call_outcome", default: "", null: false
    t.date "date_of_birth", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_identifier"], name: "index_referrals_on_agent_identifier"
  end

  add_foreign_key "pension_summary_step_viewings", "pension_summaries"
end
