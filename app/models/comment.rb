class Comment < ActiveRecord::Base
  belongs_to :article

  validates :article_id, :presence => true

  def word_count
    body.split.count
  end

  def self.total_word_count
    all.inject(0) {|total, a| total += a.word_count }
  end
end
