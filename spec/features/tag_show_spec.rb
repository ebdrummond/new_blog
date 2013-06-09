require 'spec_helper'

describe "the tag show page" do
  let!(:post){Post.create(title: "First blog post", body: "here I am!", category: "professional")}
  let!(:tag){Tag.create(name: "taggie")}
  let!(:tagging){Tagging.create(post_id: post.id, tag_id: tag.id)}

  before do
    visit tag_path(tag)
  end

  it "shows all articles associated with the tag" do
    expect(page).to have_link("First blog post")
  end

  it "directs to the article page when an article link is clicked" do
    click_link("First blog post")
    expect(current_path).to eq(post_path(post))
  end
end