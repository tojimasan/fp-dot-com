require 'rails_helper'

RSpec.describe Client, type: :model do
  it "is valid with name" do
    client = Client.new(
      name: 'kazuto',
    )
    expect(client).to be_valid
  end

  it "it invalid without a name" do
    client = Client.new(
      name: '',
    )
    expect(client).to_not be_valid
  end
end
