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

ActiveRecord::Schema[7.1].define(version: 2025_04_03_105654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "text"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "articles", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assessments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "total_score"
    t.string "level"
    t.text "ai_insights"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_assessments_on_user_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "business_name"
    t.string "website_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_brands_on_user_id"
  end

  create_table "business_idea_definitions", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.text "problem_statement"
    t.text "solution"
    t.text "target_audience"
    t.text "market_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "ai_suggestions"
    t.text "target_customer_segment"
    t.text "value_proposition"
    t.text "key_differentiators"
    t.text "ai_summary"
    t.boolean "ai_generated", default: false
    t.boolean "completed", default: false
    t.index ["business_idea_id"], name: "index_business_idea_definitions_on_business_idea_id"
  end

  create_table "business_ideas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "suggestions"
    t.integer "user_id"
    t.string "status", default: "Draft"
    t.bigint "industry_type_id", default: 1, null: false
    t.index ["industry_type_id"], name: "index_business_ideas_on_industry_type_id"
    t.index ["user_id"], name: "index_business_ideas_on_user_id"
  end

  create_table "business_model_canvas", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.text "key_partners", default: ""
    t.text "key_activities", default: ""
    t.text "key_resources", default: ""
    t.text "value_propositions", default: ""
    t.text "customer_relationships", default: ""
    t.text "channels", default: ""
    t.text "customer_segments", default: ""
    t.text "cost_structure", default: ""
    t.text "revenue_streams", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "key_metrics", default: ""
    t.text "customer_pains", default: ""
    t.text "customer_gains", default: ""
    t.text "cost_breakdown", default: ""
    t.text "pricing_strategy", default: ""
    t.text "distribution_channels", default: ""
    t.text "partnerships", default: ""
    t.jsonb "ai_suggestions", default: {}
    t.jsonb "user_input", default: {}
    t.jsonb "industry_insights", default: {}
    t.jsonb "competitor_insights", default: {}
    t.index ["ai_suggestions"], name: "index_business_model_canvas_on_ai_suggestions", using: :gin
    t.index ["business_idea_id"], name: "index_business_model_canvas_on_business_idea_id"
    t.index ["competitor_insights"], name: "index_business_model_canvas_on_competitor_insights", using: :gin
    t.index ["industry_insights"], name: "index_business_model_canvas_on_industry_insights", using: :gin
    t.index ["user_input"], name: "index_business_model_canvas_on_user_input", using: :gin
  end

  create_table "competitor_analyses", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_competitor_analyses_on_business_idea_id"
  end

  create_table "competitors", force: :cascade do |t|
    t.bigint "competitor_analysis_id", null: false
    t.string "name"
    t.text "description"
    t.text "five_forces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competitor_analysis_id"], name: "index_competitors_on_competitor_analysis_id"
  end

  create_table "entrepreneurial_skills_user_responses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.integer "answer_id", null: false
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_entrepreneurial_skills_user_responses_on_answer_id"
    t.index ["question_id"], name: "index_entrepreneurial_skills_user_responses_on_question_id"
    t.index ["user_id"], name: "index_entrepreneurial_skills_user_responses_on_user_id"
  end

  create_table "financial_plans", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.text "startup_costs"
    t.text "revenue_forecasts"
    t.text "cost_forecasts"
    t.text "break_even_analysis"
    t.text "cash_flow_forecast"
    t.text "funding_needs"
    t.text "profit_and_loss"
    t.text "risk_assessment"
    t.text "kpi_milestones"
    t.boolean "ai_generated", default: false
    t.integer "progress_percentage", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_financial_plans_on_business_idea_id"
  end

  create_table "funding_plans", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.text "bank_loan_borrowing"
    t.text "alternative_funding"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_funding_plans_on_business_idea_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.date "due_date"
    t.integer "priority", default: 0
    t.string "action_point"
    t.integer "status", default: 0
    t.boolean "added_to_business_plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_ideas_on_user_id"
  end

  create_table "industry_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "market_researches", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.text "market_trends"
    t.text "competitor_insights"
    t.text "customer_segments"
    t.text "industry_reports"
    t.text "ai_suggestions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_market_researches_on_business_idea_id"
  end

  create_table "pestel_analyses", force: :cascade do |t|
    t.integer "business_idea_id", null: false
    t.text "political"
    t.text "economic"
    t.text "social"
    t.text "technological"
    t.text "environmental"
    t.text "legal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_pestel_analyses_on_business_idea_id"
  end

  create_table "porter_five_forces", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.integer "threat_of_new_entrants"
    t.integer "supplier_power"
    t.integer "buyer_power"
    t.integer "threat_of_substitutes"
    t.integer "industry_rivalry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_porter_five_forces_on_business_idea_id"
  end

  create_table "porters_five_forces", force: :cascade do |t|
    t.integer "business_idea_id", null: false
    t.text "threat_of_new_entrants"
    t.text "bargaining_power_of_suppliers"
    t.text "bargaining_power_of_buyers"
    t.text "threat_of_substitutes"
    t.text "industry_rivalry"
    t.text "analysis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_porters_five_forces_on_business_idea_id"
  end

  create_table "pswot_analyses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "strengths"
    t.text "weaknesses"
    t.text "opportunities"
    t.text "threats"
    t.text "analysis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pswot_analyses_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "category"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smart_goals", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.string "category", null: false
    t.date "start_date"
    t.date "due_date"
    t.boolean "milestone", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_smart_goals_on_business_idea_id"
  end

  create_table "stage_methods", force: :cascade do |t|
    t.integer "method_type"
    t.bigint "stage_id", null: false
    t.jsonb "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stage_id"], name: "index_stage_methods_on_stage_id"
  end

  create_table "stages", force: :cascade do |t|
    t.string "name"
    t.integer "stage_type"
    t.bigint "business_idea_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "progress_percentage", default: 0
    t.index ["business_idea_id"], name: "index_stages_on_business_idea_id"
  end

  create_table "strategy_developments", force: :cascade do |t|
    t.bigint "business_idea_id", null: false
    t.text "vision"
    t.text "mission"
    t.text "strategic_goals"
    t.text "core_strategy"
    t.text "value_chain"
    t.text "marketing_strategy"
    t.text "competitive_strategy"
    t.text "swot_actions"
    t.text "kpis"
    t.boolean "ai_generated"
    t.json "ai_suggestions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_strategy_developments_on_business_idea_id"
  end

  create_table "swot_analyses", force: :cascade do |t|
    t.integer "business_idea_id", null: false
    t.text "strengths"
    t.text "weaknesses"
    t.text "opportunities"
    t.text "threats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_idea_id"], name: "index_swot_analyses_on_business_idea_id"
  end

  create_table "user_responses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.integer "answer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_user_responses_on_answer_id"
    t.index ["question_id"], name: "index_user_responses_on_question_id"
    t.index ["user_id"], name: "index_user_responses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "assessments", "users"
  add_foreign_key "brands", "users"
  add_foreign_key "business_idea_definitions", "business_ideas"
  add_foreign_key "business_ideas", "industry_types"
  add_foreign_key "business_ideas", "users"
  add_foreign_key "business_model_canvas", "business_ideas"
  add_foreign_key "competitor_analyses", "business_ideas"
  add_foreign_key "competitors", "competitor_analyses"
  add_foreign_key "entrepreneurial_skills_user_responses", "answers"
  add_foreign_key "entrepreneurial_skills_user_responses", "questions"
  add_foreign_key "entrepreneurial_skills_user_responses", "users"
  add_foreign_key "financial_plans", "business_ideas"
  add_foreign_key "funding_plans", "business_ideas"
  add_foreign_key "market_researches", "business_ideas"
  add_foreign_key "pestel_analyses", "business_ideas"
  add_foreign_key "porter_five_forces", "business_ideas"
  add_foreign_key "porters_five_forces", "business_ideas"
  add_foreign_key "pswot_analyses", "users"
  add_foreign_key "smart_goals", "business_ideas"
  add_foreign_key "stage_methods", "stages"
  add_foreign_key "stages", "business_ideas"
  add_foreign_key "strategy_developments", "business_ideas"
  add_foreign_key "swot_analyses", "business_ideas"
  add_foreign_key "user_responses", "answers"
  add_foreign_key "user_responses", "questions"
  add_foreign_key "user_responses", "users"
end
