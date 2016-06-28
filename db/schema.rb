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

ActiveRecord::Schema.define(version: 20160621153405) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.integer  "levelpoints"
    t.integer  "chapter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "tier"
    t.text     "shortname"
    t.integer  "content_id",   null: false
    t.string   "content_type", null: false
    t.integer  "level_id"
  end

  add_index "activities", ["chapter_id"], name: "index_activities_on_chapter_id"
  add_index "activities", ["content_type", "content_id"], name: "index_activities_on_content_type_and_content_id"
  add_index "activities", ["level_id"], name: "index_activities_on_level_id"

  create_table "activity_assessments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_edges", id: false, force: :cascade do |t|
    t.integer "head_id"
    t.integer "tail_id"
  end

  add_index "activity_edges", ["head_id"], name: "index_activity_edges_on_head_id"
  add_index "activity_edges", ["tail_id"], name: "index_activity_edges_on_tail_id"

  create_table "activity_exercises", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_lectures", force: :cascade do |t|
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_statuses", force: :cascade do |t|
    t.boolean  "is_completed"
    t.integer  "status"
    t.integer  "activity_id"
    t.integer  "course_enrollment_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "activity_statuses", ["activity_id"], name: "index_activity_statuses_on_activity_id"
  add_index "activity_statuses", ["course_enrollment_id"], name: "index_activity_statuses_on_course_enrollment_id"

  create_table "admin_users", force: :cascade do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "answers", force: :cascade do |t|
    t.integer  "m_question_id"
    t.text     "text"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "answers", ["m_question_id"], name: "index_answers_on_m_question_id"

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id"

  create_table "chapter_edges", id: false, force: :cascade do |t|
    t.integer "head_id"
    t.integer "tail_id"
  end

  add_index "chapter_edges", ["head_id"], name: "index_chapter_edges_on_head_id"
  add_index "chapter_edges", ["tail_id"], name: "index_chapter_edges_on_tail_id"

  create_table "chapters", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.string   "description"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "tier"
  end

  add_index "chapters", ["course_id"], name: "index_chapters_on_course_id"

  create_table "completed_m_questions", force: :cascade do |t|
    t.integer  "m_question_id"
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "completed_m_questions", ["answer_id"], name: "index_completed_m_questions_on_answer_id"
  add_index "completed_m_questions", ["m_question_id"], name: "index_completed_m_questions_on_m_question_id"
  add_index "completed_m_questions", ["user_id"], name: "index_completed_m_questions_on_user_id"

  create_table "completed_questionnaires", force: :cascade do |t|
    t.integer  "questionnaire_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "completed_questionnaires", ["questionnaire_id"], name: "index_completed_questionnaires_on_questionnaire_id"
  add_index "completed_questionnaires", ["user_id"], name: "index_completed_questionnaires_on_user_id"

  create_table "course_enrollments", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.boolean  "completed",          default: false
    t.boolean  "is_visible"
    t.boolean  "is_visible_friends"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "sash_id"
    t.integer  "level",              default: 0
    t.integer  "level_id"
  end

  add_index "course_enrollments", ["course_id"], name: "index_course_enrollments_on_course_id"
  add_index "course_enrollments", ["level_id"], name: "index_course_enrollments_on_level_id"
  add_index "course_enrollments", ["user_id"], name: "index_course_enrollments_on_user_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creator_id",  null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "feedbacks", ["commentable_type", "commentable_id"], name: "index_feedbacks_on_commentable_type_and_commentable_id"

  create_table "levels", force: :cascade do |t|
    t.integer  "level"
    t.integer  "level_pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "m_questions", force: :cascade do |t|
    t.integer  "questionnaire_id"
    t.integer  "correct_answer_id"
    t.text     "text"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "m_questions", ["questionnaire_id"], name: "index_m_questions_on_questionnaire_id"

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.integer  "qu_container_id"
    t.string   "qu_container_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "questionnaires", ["qu_container_type", "qu_container_id"], name: "index_questionnaires_on_qu_container_type_and_qu_container_id"

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "username"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.boolean  "is_instructor"
    t.string   "provider"
    t.string   "userid"
    t.string   "avatar"
    t.string   "aboutme"
    t.date     "birthday"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
