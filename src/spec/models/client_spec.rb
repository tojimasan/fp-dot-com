require 'rails_helper'

RSpec.describe Client, type: :model do
  it "is valid with default" do
    client = FactoryBot.build(:client)
    expect(client).to be_valid
  end

  it "is valid with specific name" do
    client = FactoryBot.build(:client, name: 'ushijima')
    expect(client).to be_valid
    expect(client.name).to eq 'ushijima'
  end

  it "is valid with trait" do
    kazuto = FactoryBot.build(:kazutoクライアント)
    expect(kazuto).to be_valid
    expect(kazuto.name).to eq 'kazutoクライアント'
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
