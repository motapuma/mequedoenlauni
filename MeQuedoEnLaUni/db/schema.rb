# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170117030817) do

  create_table "multiple_option_answers", force: true do |t|
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "multiple_option_question_id"
  end

  create_table "multiple_option_questions", force: true do |t|
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correct_answer_id"
    t.integer  "subject"
    t.integer  "paragraph_id"
    t.integer  "question_table_figure_id"
  end

  add_index "multiple_option_questions", ["correct_answer_id"], name: "index_multiple_option_questions_on_correct_answer_id"
  add_index "multiple_option_questions", ["paragraph_id"], name: "index_multiple_option_questions_on_paragraph_id"
  add_index "multiple_option_questions", ["question_table_figure_id"], name: "index_multiple_option_questions_on_question_table_figure_id"

  create_table "paragraphs", force: true do |t|
    t.text     "paragraph"
    t.text     "post_paragraph"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_table_figures", force: true do |t|
    t.text     "table_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
