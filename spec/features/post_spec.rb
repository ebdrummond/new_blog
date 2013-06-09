require 'spec_helper'

describe "An individual post show page" do
  let!(:post){Post.create(title: "First blog post", body: "here I am!", category: "professional")}
  let!(:tag){Tag.create(name: "taggie")}
  let!(:tag2){Tag.create(name: "hello world")}
  let!(:tagging){Tagging.create(post_id: post.id, tag_id: tag.id)}
  let!(:tagging2){Tagging.create(post_id: post.id, tag_id: tag2.id)}

  before do
    visit post_path(post)
  end

  it "displays the title and body of an post" do
    expect(page).to have_content("First blog post")
    expect(page).to have_content("here I am!")
  end

  it "returns you to the home page when the site headline is clicked" do
    click_link("It's never too late to hit restart")
    expect(current_path).to eq(root_path)
  end

  it "has a list of tags for each post" do
    expect(page).to have_content("hello world")
    expect(page).to have_content("taggie")
  end

  it "directs to the tag show page when a tag link is clicked" do
    click_link("taggie")
    expect(current_path).to eq(tag_path(tag))
  end

  context "when logged in" do
    before do
      @user = User.create(name: "Erin", email: "e.b.drummond@gmail.com", password: "yes")
      visit login_path
      fill_in("Email", with: "e.b.drummond@gmail.com")
      fill_in("Password", with: "yes")
      click_button("Log in")
      visit post_path(post)
    end

    it "has a button to edit the post" do
      expect(page).to have_button("Edit")
    end

    it "takes you to the edit post page when the button is clicked" do
      click_button("Edit")
      expect(current_path).to eq(edit_post_path(post))
    end

    it "has a button to delete the post" do
      expect(page).to have_button("Delete")
    end

    it "deletes the post when the button is clicked" do
      expect{click_button("Delete")}.to change(Post, :count).by(-1)
    end
  end

  context "when not logged in" do
    it "does not have buttons to edit or delete the post" do
      expect(page).to_not have_button("Edit")
      expect(page).to_not have_button("Delete")
    end
  end
end