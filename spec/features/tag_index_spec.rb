require 'spec_helper'

describe "tag index page" do
  let!(:post){Post.create(title: "First blog post", body: "here I am!", category: "professional")}
  let!(:tag){Tag.create(name: "taggie")}
  let!(:tagging){Tagging.create(post_id: post.id, tag_id: tag.id)}
  let!(:tag2){Tag.create(name: "taggie2")}
  let!(:tagging2){Tagging.create(post_id: post.id, tag_id: tag2.id)}

  it "lists all the taggings" do
    visit tags_path
    expect(page).to have_content("taggie")
    expect(page).to have_content("taggie2")
  end

  it "takes you to the show page when you click on a tag" do
    visit tags_path
    click_link("taggie")
    expect(current_path).to eq(tag_path(tag))
  end
end