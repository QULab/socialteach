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

ActiveRecord::Schema.define(version: 20160723021622) do

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
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "tier"
    t.text     "shortname"
    t.integer  "content_id",               null: false
    t.string   "content_type",             null: false
    t.integer  "level_id"
    t.integer  "difficulty",   default: 0, null: false
  end

  add_index "activities", ["chapter_id"], name: "index_activities_on_chapter_id"
  add_index "activities", ["content_type", "content_id"], name: "index_activities_on_content_type_and_content_id"
  add_index "activities", ["level_id"], name: "index_activities_on_level_id"

  create_table "activity_assessments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_duells", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "challenger_id"
    t.integer  "enemy_id"
    t.boolean  "enemy_bool"
    t.boolean  "challenger_bool"
    t.boolean  "master"
    t.integer  "score"
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
    t.integer  "learningpoints_id"
    t.integer  "levelpoints_id"
  end

  add_index "activity_statuses", ["activity_id"], name: "index_activity_statuses_on_activity_id"
  add_index "activity_statuses", ["course_enrollment_id"], name: "index_activity_statuses_on_course_enrollment_id"
  add_index "activity_statuses", ["learningpoints_id"], name: "index_activity_statuses_on_learningpoints_id"
  add_index "activity_statuses", ["levelpoints_id"], name: "index_activity_statuses_on_levelpoints_id"

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
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "correct",       default: false
  end

  add_index "answers", ["m_question_id"], name: "index_answers_on_m_question_id"

  create_table "answers_completed_m_questions", id: false, force: :cascade do |t|
    t.integer "completed_m_question_id", null: false
    t.integer "answer_id",               null: false
  end

  add_index "answers_completed_m_questions", ["answer_id", "completed_m_question_id"], name: "i_answers_c_questions_on_answer_id_and_c_question_id"
  add_index "answers_completed_m_questions", ["completed_m_question_id", "answer_id"], name: "i_answers_c_questions_on_c_question_id_and_answer_id"

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

  create_table "chapter_statuses", force: :cascade do |t|
    t.boolean  "skip",                 default: false
    t.boolean  "finished",             default: false
    t.integer  "course_enrollment_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.float    "difficultyFit",        default: 0.0
    t.integer  "chapter_id"
  end

  add_index "chapter_statuses", ["chapter_id"], name: "index_chapter_statuses_on_chapter_id"
  add_index "chapter_statuses", ["course_enrollment_id"], name: "index_chapter_statuses_on_course_enrollment_id"

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

  create_table "comment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "comment_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "comment_anc_desc_udx", unique: true
  add_index "comment_hierarchies", ["descendant_id"], name: "comment_desc_idx"

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.text     "body"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "parent_id"
    t.integer  "author_id"
    t.integer  "course_id"
    t.integer  "activity_id"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "comments", ["activity_id"], name: "index_comments_on_activity_id"
  add_index "comments", ["cached_votes_down"], name: "index_comments_on_cached_votes_down"
  add_index "comments", ["cached_votes_score"], name: "index_comments_on_cached_votes_score"
  add_index "comments", ["cached_votes_total"], name: "index_comments_on_cached_votes_total"
  add_index "comments", ["cached_votes_up"], name: "index_comments_on_cached_votes_up"
  add_index "comments", ["cached_weighted_average"], name: "index_comments_on_cached_weighted_average"
  add_index "comments", ["cached_weighted_score"], name: "index_comments_on_cached_weighted_score"
  add_index "comments", ["cached_weighted_total"], name: "index_comments_on_cached_weighted_total"
  add_index "comments", ["course_id"], name: "index_comments_on_course_id"

  create_table "completed_m_questions", force: :cascade do |t|
    t.integer  "m_question_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "completed_questionnaire_id"
  end

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

  create_table "course_badges", force: :cascade do |t|
    t.string   "badge"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "width"
    t.integer  "height"
    t.integer  "course_id"
    t.integer  "user_id"
  end

  add_index "course_badges", ["course_id"], name: "index_course_badges_on_course_id"
  add_index "course_badges", ["user_id"], name: "index_course_badges_on_user_id"

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
    t.integer  "current_chapter_id"
  end

  add_index "course_enrollments", ["course_id"], name: "index_course_enrollments_on_course_id"
  add_index "course_enrollments", ["level_id"], name: "index_course_enrollments_on_level_id"
  add_index "course_enrollments", ["user_id"], name: "index_course_enrollments_on_user_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "creator_id",                  null: false
    t.boolean  "published",   default: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "feedbacks", ["commentable_type", "commentable_id"], name: "index_feedbacks_on_commentable_type_and_commentable_id"

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.integer  "level"
    t.integer  "level_pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "m_questions", force: :cascade do |t|
    t.integer  "questionnaire_id"
    t.text     "text"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
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

  create_table "merits", force: :cascade do |t|
    t.string   "course"
    t.float    "points"
    t.datetime "earned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owned_badges", force: :cascade do |t|
    t.integer  "course_badge_id"
    t.integer  "course_enrollment_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "owned_badges", ["course_badge_id"], name: "index_owned_badges_on_course_badge_id"
  add_index "owned_badges", ["course_enrollment_id"], name: "index_owned_badges_on_course_enrollment_id"

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

  create_table "unlock_course_badges", force: :cascade do |t|
    t.integer  "course_badge_id"
    t.integer  "activity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "unlock_course_badges", ["activity_id"], name: "index_unlock_course_badges_on_activity_id"
  add_index "unlock_course_badges", ["course_badge_id"], name: "index_unlock_course_badges_on_course_badge_id"

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
    t.integer  "win"
    t.integer  "lose"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
