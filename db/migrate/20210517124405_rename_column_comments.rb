class RenameColumnComments < ActiveRecord::Migration[6.0]
  def change
  	rename_column(:comments, :comment, :remarks)
  end
end
