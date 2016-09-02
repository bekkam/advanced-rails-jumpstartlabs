# Module to factor out common class and instance methods of article and comment models:

# article.rb: 
# def word_count
# body.split.count
# end

# def self.total_word_count
# all.inject(0) {|total, a| total += a.word_count }
# end

#############################################

# comment.rb:
# def word_count
# body.split.count
# end

# def self.total_word_count
# all.inject(0) {|total, a| total += a.word_count }
# end

##################################################

module TextContent
  extend ActiveSupport::Concern

  def word_count
    body.split.count
  end

  module ClassMethods
    def total_word_count
      all.inject(0) {|total, a| total += a.word_count }
    end
  end

  included do
    has_one :moderator_approval, as: :content
  end
end


# Now, can replace the above methods in comment and article by simply including the module:
# class Article < ActiveRecord::Base
#   include TextContent
# end

# class Comment < ActiveRecord::Base
#   include TextContent
# end