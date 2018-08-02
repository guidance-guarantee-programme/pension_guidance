# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180802075219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

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
    t.boolean "defined_contribution"
    t.boolean "defined_benefit"
    t.boolean "uncertain"
  end

  create_table "pension_summary_step_viewings", force: :cascade do |t|
    t.uuid "pension_summary_id"
    t.string "step", limit: 100, null: false
    t.datetime "created_at", null: false
    t.index ["pension_summary_id"], name: "index_pension_summary_step_viewings_on_pension_summary_id"
  end

  add_foreign_key "pension_summary_step_viewings", "pension_summaries"
end