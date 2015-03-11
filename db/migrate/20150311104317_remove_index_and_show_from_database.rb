class RemoveIndexAndShowFromDatabase < ActiveRecord::Migration
  def change
    remove_column :feeds, :index
    remove_column :feeds, :show
  end
end
