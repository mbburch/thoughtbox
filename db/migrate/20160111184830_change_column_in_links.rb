class ChangeColumnInLinks < ActiveRecord::Migration
  def change
    remove_column :links, :status
    add_column :links, :read, :boolean, default: false
  end
end
