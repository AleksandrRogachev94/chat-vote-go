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

ActiveRecord::Schema.define(version: 20170522205062) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatrooms", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chatrooms_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "rs_evaluations", force: :cascade do |t|
    t.string   "reputation_name"
    t.string   "source_type"
    t.integer  "source_id"
    t.string   "target_type"
    t.integer  "target_id"
    t.float    "value",           default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
    t.index ["reputation_name", "source_id", "source_type", "target_id", "target_type"], name: "index_rs_evaluations_on_reputation_name_and_source_and_target", unique: true, using: :btree
    t.index ["reputation_name"], name: "index_rs_evaluations_on_reputation_name", using: :btree
    t.index ["source_id", "source_type"], name: "index_rs_evaluations_on_source_id_and_source_type", using: :btree
    t.index ["target_id", "target_type"], name: "index_rs_evaluations_on_target_id_and_target_type", using: :btree
  end

  create_table "rs_reputation_messages", force: :cascade do |t|
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.float    "weight",      default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["receiver_id", "sender_id", "sender_type"], name: "index_rs_reputation_messages_on_receiver_id_and_sender", unique: true, using: :btree
    t.index ["receiver_id"], name: "index_rs_reputation_messages_on_receiver_id", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_rs_reputation_messages_on_sender_id_and_sender_type", using: :btree
  end

  create_table "rs_reputations", force: :cascade do |t|
    t.string   "reputation_name"
    t.float    "value",           default: 0.0
    t.string   "aggregated_by"
    t.string   "target_type"
    t.integer  "target_id"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
    t.index ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true, using: :btree
    t.index ["reputation_name"], name: "index_rs_reputations_on_reputation_name", using: :btree
    t.index ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type", using: :btree
  end

  create_table "suggestions", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "api_link"
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_suggestions_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_suggestions_on_user_id", using: :btree
  end

  create_table "user_chatrooms", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_user_chatrooms_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_user_chatrooms_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "interests"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
