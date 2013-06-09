require 'spec_helper'

describe User do
  it "has a name, email, and password" do
    user = User.create(name: "Erin", email: "e.b.drummond@gmail.com", password: "yes")
    expect(user.name).to eq "Erin"
    expect(user.email).to eq "e.b.drummond@gmail.com"
    expect(user.password).to eq "yes"
  end

  it "validates the presence of a name" do
    user = User.create(email: "e.b.drummond@gmail.com", password: "yes")
    user.save
    expect(user).to be_invalid
  end

  it "validates the presence of an email" do
    user = User.create(name: "Erin", password: "yes")
    user.save
    expect(user).to be_invalid
  end

  it "validates the presence of a password" do
    user = User.create(name: "Erin", email: "e.b.drummond@gmail.com")
    user.save
    expect(user).to be_invalid
  end
end