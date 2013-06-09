class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  def to_s
    name
  end

  def article_count
    taggings.count
  end

  def self.professional
    Post.professional.collect{|p| p.tags}.flatten.uniq
  end

  def self.personal
    Post.personal.collect{|p| p.tags}.flatten.uniq
  end
end
