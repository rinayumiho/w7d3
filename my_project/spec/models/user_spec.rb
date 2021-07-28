require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject(:user) do
    FactoryBot.build(:user,
      username: "Chris",
      password: "chung123"
    )
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  it "creates a password digest when a password is given" do
    expect(user.password_digest).to_not be_nil
  end

  describe "#is_password?" do
    it "should verify the correct password is correct" do
      expect(user.is_password?("chung123")).to be true
    end

    it "should verify the incorret password is incorret" do
      expect(user.is_password?("chung12")).to be false
    end
  end

  describe "::find_by_credentials" do
    before { user.save! }

    it "should return the user if we providing the correct name/password" do
      expect(User.find_by_credentials("Chris", "chung123")).to eq(user)
    end

    it "should return nilr if we providing the incorrect name/password" do
      expect(User.find_by_credentials("Chris", "chung12")).to be_nil
    end
  end


end
