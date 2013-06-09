require 'spec_helper'

describe "the home page" do
  let!(:post){Post.create(title: "First blog post", body: "here I am!", category: "professional")}
  let!(:post2){Post.create(title: "First personal blog post", body: "here I am!", category: "personal")}

  before do
    visit root_path
  end

  it "has the blog title" do
    expect(page).to have_content("It's never too late to hit restart")
  end

  it "displays recent posts" do
    expect(page).to have_content("First blog post")
  end

  it "has links to each post from the post show page" do
    expect(page).to have_link("First blog post")
  end

  it "takes me to each post show page when I click the link" do
    click_link("First blog post")
    expect(current_path).to eq(post_path(post))
  end

  it "defaults to showing professional posts" do
    expect(page).to have_content("Professional Posts")
  end

  it "has a link to look at personal posts" do
    expect(page).to have_link("Personal Posts")
  end

  it "takes you to the personal posts page when you click the link" do
    click_link("Personal Posts")
    expect(current_path).to eq(personal_index_path)
  end

  it "does not have the personal post" do
    expect(page).to_not have_content("First personal blog post")
  end

  context "when I'm logged in" do
    before do
      User.create(name: "Erin", email: "e.b.drummond@gmail.com", password: "yes")
      click_link("Log in")
      fill_in("Email", with: "e.b.drummond@gmail.com")
      fill_in("Password", with: "yes")
      click_button("Log in")
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

    it "has a link to log in" do
      expect(page).to have_link("Log in")
    end

    it "takes me to the log in page when I click the link" do
      click_link("Log in")
      expect(current_path).to eq(login_path)
    end
  end

  context "in the side bar" do
    it "has recent posts" do
      expect(page).to have_content("Recent posts:")
    end

    it "has a list of tags" do
      expect(page).to have_content("Tags:")
    end
  end
end