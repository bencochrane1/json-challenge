class ChangeColumnNameAwayFromType < ActiveRecord::Migration
  def change
    rename_column :feeds, :type, :network
  end
end
