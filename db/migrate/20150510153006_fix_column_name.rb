class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :api_keys, :user_id, :group_id
  end
end
