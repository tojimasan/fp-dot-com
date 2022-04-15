require 'rails_helper'

RSpec.describe Client, type: :model do
  it "is valid with name" do
    client = FactoryBot.build(:client, name: "kazuto")
    expect(client).to be_valid
  end

  it "is invalid with a empty name" do
    client = FactoryBot.build(:client, name: "")
    expect(client).to_not be_valid
  end

  it "is invalid without a name" do
    client = FactoryBot.build(:client, name: nil)
    client.valid?
    expect(client.errors[:name]).to include("can't be blank")
  end
end
