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

ActiveRecord::Schema.define(:version => 20110711071412) do

  create_table "arguments", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "mtitle"
    t.text     "mkey"
    t.text     "mdescription"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "companies", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.string   "name"
    t.text     "description"
    t.string   "piva"
    t.string   "url_site"
    t.string   "email_address"
    t.string   "phone"
    t.string   "fax"
    t.string   "timetable"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "youtube"
    t.integer  "tokens"
    t.boolean  "is_exclusive"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.integer  "department_id"
    t.string   "address"
    t.boolean  "is_enabled",    :default => false
    t.integer  "rank",          :default => 0
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "containers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "is_public"
    t.integer  "order_show"
    t.string   "template"
    t.integer  "user_id"
    t.string   "mkey"
    t.string   "mdescription"
    t.string   "mtitle"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "place_holder"
    t.string   "sub_title"
  end

  create_table "delivers", :force => true do |t|
    t.integer  "company_id"
    t.integer  "estimate_id"
    t.boolean  "is_delivered"
    t.text     "feedback"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code"
  end

  create_table "estimates", :force => true do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "address"
    t.integer  "city_id"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note"
  end

  create_table "needs", :force => true do |t|
    t.integer  "category_id"
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", :force => true do |t|
    t.integer  "continer_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "intro"
    t.text     "body"
    t.text     "mkey"
    t.text     "mdescription"
    t.string   "slug"
    t.integer  "argument_id"
    t.integer  "user_id"
    t.boolean  "is_public"
    t.boolean  "is_commentable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_imege"
    t.integer  "hit"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "email"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_enabled"
    t.string   "ancestry"
    t.integer  "user_id"
    t.integer  "hit"
    t.text     "mkey"
    t.text     "mdescription"
    t.text     "mtitle"
  end

  add_index "questions", ["ancestry"], :name => "index_questions_on_ancestry"

  create_table "queued_emails", :force => true do |t|
    t.string   "mailer"
    t.string   "mailer_method"
    t.text     "args"
    t.integer  "priority",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "category_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiny_prints", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiny_videos", :force => true do |t|
    t.string   "original_file_name"
    t.string   "original_file_size"
    t.string   "original_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "rpx_identifier"
    t.string   "photo"
    t.string   "verifiedEmail"
    t.string   "url"
    t.string   "providerName"
    t.string   "address"
    t.string   "displayName"
    t.text     "info"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "zones", :force => true do |t|
    t.integer  "city_id"
    t.integer  "department_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
