class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :index
      t.string :show

      t.timestamps null: false
    end
  end
end
