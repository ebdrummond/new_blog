require 'spec_helper'

describe "the new post page" do
  before do
    visit new_post_path
  end

  it "displays boxes to enter in a new post title and body" do
    expect(page).to have_content("Title")
    expect(page).to have_content("Body")
    expect(page).to have_content("Category")
  end

  context "with valid information" do
    before do
      fill_in("Title", with: "New post")
      fill_in("Body", with: "This is a new post.")
      fill_in("Category", with: "professional")
    end

    it "creates the post" do
      expect{click_button("submit")}.to change(Post, :count).by(1)
    end

    it "redirects to the home page" do
      click_button("submit")
      expect(current_path).to eq(root_path)
    end

    it "notifies you the post was created" do
      click_button("submit")
      expect(page).to have_content("Post created!")
    end
  end

  context "with invalid information" do
    it "validates the presence of a title" do
      fill_in("Body", with: "New post")
      fill_in("Category", with: "professional")
      click_button("submit")
      expect(page).to have_content("Unable to create post.")
      expect(page).to have_content("Title can't be blank")
    end

    it "validates the presence of a title" do
      fill_in("Title", with: "New post")
      fill_in("Category", with: "professional")
      click_button("submit")
      expect(page).to have_content("Unable to create post.")
      expect(page).to have_content("Body can't be blank")
    end

    it "validates the presence of a title" do
      fill_in("Title", with: "New post")
      fill_in("Body", with: "New post")
      click_button("submit")
      expect(page).to have_content("Unable to create post.")
      expect(page).to have_content("Category can't be blank")
    end
  end
end