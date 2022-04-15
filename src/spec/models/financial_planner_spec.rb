require 'rails_helper'

RSpec.describe FinancialPlanner, type: :model do
  it "is valid with name" do
    financial_planner = FactoryBot.build(:financial_planner, name: "kazuto")
    expect(financial_planner).to be_valid
  end

  it "is invalid with a empty name" do
    financial_planner = FactoryBot.build(:financial_planner, name: "")
    expect(financial_planner).to_not be_valid
  end

  it "is invalid without a name" do
    financial_planner = FactoryBot.build(:financial_planner, name: nil)
    financial_planner.valid?
    expect(financial_planner.errors[:name]).to include("can't be blank")
  end
end
