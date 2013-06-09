require 'spec_helper'

describe "the personal posts index" do
  let!(:post){Post.create(title: "First blog post", body: "here I am!", category: "professional")}
  let!(:post2){Post.create(title: "First personal blog post", body: "here I am!", category: "personal")}

  before do
    visit personal_index_path
  end

  it "displays only personal posts" do
    expect(page).to have_content("First personal blog post")
    expect(page).to_not have_content("First blog post")
  end

  it "has a link to view professional posts" do
    expect(page).to have_link("Professional Posts")
  end

  it "directs to the root path when the link is clicked" do
    click_link("Professional Posts")
    expect(current_path).to eq(root_path)
  end

  context "when I'm logged in" do
    before do
      visit root_path
      User.create(name: "Erin", email: "e.b.drummond@gmail.com", password: "yes")
      click_link("Log in")
      fill_in("Email", with: "e.b.drummond@gmail.com")
      fill_in("Password", with: "yes")
      click_button("Log in")
      visit personal_index_path
    end

    it "has a button to create a new post" do
      expect(page).to have_button("Create new post")
    end

    it "takes me to the new post page when I click the button" do
      click_button("Create new post")
      expect(current_path).to eq(new_post_path)
    end

    it "has a link to log out" do
      expect(page).to have_link("Log out")
    end

    it "logs me out when I click the logout link" do
      click_link("Log out")
      expect(page).to have_content("Au revoir!")
    end
  end

  context "when not logged in" do
    it "does not have a button to create a new post" do
      expect(page).to_not have_button("Create new post")
    end
  end
end