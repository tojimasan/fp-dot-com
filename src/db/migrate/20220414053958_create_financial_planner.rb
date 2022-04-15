class CreateFinancialPlanner < ActiveRecord::Migration[6.1]
  def change
    create_table :financial_planners do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
