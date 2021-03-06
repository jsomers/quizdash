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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110329050506) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_quizzes", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "quiz_id"
  end

  create_table "dashes", :force => true do |t|
    t.text     "board"
    t.text     "players"
    t.integer  "quiz_id"
    t.datetime "started_at"
    t.float    "avg_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "prompt"
    t.text     "permissible_answers"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "time_limit"
    t.integer  "play_count",   :default => 0
    t.float    "avg_score"
    t.float    "fastest_time"
    t.datetime "last_played"
  end

end
