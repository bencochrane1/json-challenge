ActiveRecord::Schema.define(version: 20150311104317) do

  create_table "feeds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "username"
    t.string   "name"
    t.string   "picture"
    t.string   "status"
    t.string   "tweet"
    t.string   "network"
  end

end
