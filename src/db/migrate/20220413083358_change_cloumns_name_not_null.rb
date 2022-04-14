class ChangeCloumnsNameNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :clients, :name, false
  end
end
