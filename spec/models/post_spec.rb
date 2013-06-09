require 'spec_helper'

describe Post do
  it "has a title, body, and type" do
    post = Post.create(title: "first post", body: "here I am!", category: "personal")
    expect(post.title).to eq("first post")
    expect(post.body).to eq("here I am!")
    expect(post.category).to eq("personal")
  end

  it "validates the presence of a title" do
    post = Post.create(body: "here I am!", category: "personal")
    expect(post).to be_invalid
    expect(post).to have(1).error_on(:title)
  end

  it "validates the presence of a body" do
    post = Post.create(title: "first post", category: "personal")
    expect(post).to be_invalid
    expect(post).to have(1).error_on(:body)
  end

  it "validates the presence of a category" do
    post = Post.create(title: "first post", body: "here I am!")
    expect(post).to be_invalid
    expect(post).to have(2).errors_on(:category)
  end

  it "will only accept personal, professional, or both as a category" do
    post = Post.create(title: "first post", body: "here I am!", category: "yes")
    expect(post).to be_invalid
    expect(post).to have(1).error_on(:category)
  end

  it "returns the tags associated with the post" do
    post = Post.create(title: "first post", body: "here I am!", category: "both")
    tag = Tag.create(name: "hello")
    tag2 = Tag.create(name: "world")
    Tagging.create(tag_id: tag.id, post_id: post.id)
    Tagging.create(tag_id: tag2.id, post_id: post.id)
    expect(post.tags.count).to eq 2
  end

  it "has a published date" do
    post = Post.create(title: "first post", body: "here I am!", category: "both")
    post.created_at = "2013-05-17 13:52:59 -0600"
    post.save
    expect(post.published_date).to eq("May 17")
  end
end
