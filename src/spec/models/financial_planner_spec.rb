require 'rails_helper'

RSpec.describe FinancialPlanner, type: :model do
  it "is valid with a name" do
    financial_planner = FinancialPlanner.new(
      name: 'kazuto',
    )
    expect(financial_planner).to be_valid
  end

  it "is invalid without a name" do
    financial_planner = FinancialPlanner.new(
      name: '',
    )
    expect(financial_planner).to_not be_valid
  end
end
