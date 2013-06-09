class Post < ActiveRecord::Base
  attr_accessible :title, :body, :category, :tag_list

  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :category
  validates :category, :inclusion => { :in => ["personal", "professional", "both"] }

  has_many :tags, through: :taggings
  has_many :taggings

  def tag_list
    self.tags.join(", ")
  end

  def tag_list=(tag_list)
    tags = tag_list.split(", ").collect{|tag| tag.strip.downcase}.uniq
    new_or_found_tags = tags.collect{|tag| Tag.find_or_create_by_name(tag)}
    self.tags = new_or_found_tags
  end

  def published_date
    created_at.strftime("%B %e")
  end

  def self.professional
    self.where(:category => ["professional", "both"])
  end

  def self.personal
    self.where(:category => ["personal", "both"])
  end
end
