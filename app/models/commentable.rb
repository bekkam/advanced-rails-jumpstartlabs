# Factor out has_many :comments
# Useful in case we add a photo feature, that also permits comments
module Commentable
  extend ActiveSupport::Concern

# Define an instance method in the Commentable module named has_comments? which 
# returns true or false based on the existence of comments. 
  def has_comments?
    comments.count > 0 ? true : false
  end

  # when we extend ActiveSupport::Concern, we can call 'included' instead of self.included(including_class)
  included do
    #  extend ClassMethods
    has_many :comments
  end
end
