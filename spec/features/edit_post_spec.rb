require 'spec_helper'

describe "the edit post page" do
  let!(:post){Post.create(title: "my post", body: "my body", category: "professional")}

  before do
    visit edit_post_path(post)
  end

  it "has a heading for the post I am editing" do
    expect(page).to have_content("Edit post '#{post.title}'")
  end

  it "displays the previous content of the post for editing" do
    expect(page).to have_content("my post")
    expect(page).to have_content("my body")
  end

  context "with valid attributes" do
    it "updates the post with the new content" do
      fill_in("Title", with: "new title")
      fill_in("Body", with: "new body")
      fill_in("Category", with: "personal")
      click_button("submit")
      expect(page).to have_content("new title")
      expect(page).to have_content("new body")
    end
  end

  context "with invalid attributes" do
    it "validates the presence of a title" do
      fill_in("Title", with: nil)
      click_button("submit")
      expect(page).to have_content("Unable to update post.")
      expect(page).to have_content("Title can't be blank")
    end

    it "validates the presence of a body" do
      fill_in("Body", with: nil)
      click_button("submit")
      expect(page).to have_content("Unable to update post.")
      expect(page).to have_content("Body can't be blank")
    end

    it "validates the presence of a body" do
      fill_in("Category", with: nil)
      click_button("submit")
      expect(page).to have_content("Unable to update post.")
      expect(page).to have_content("Category can't be blank")
    end
  end
end