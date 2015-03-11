class AddColumnsToFeedModel < ActiveRecord::Migration
  def change
    add_column :feeds, :username, :string
    add_column :feeds, :name, :string
    add_column :feeds, :picture, :string
    add_column :feeds, :status, :string
    add_column :feeds, :tweet, :string
    add_column :feeds, :type, :string
  end
end
