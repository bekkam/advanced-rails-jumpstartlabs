# Factor out has_many :comments
# Useful in case we add a photo feature, that also permits comments
module Commentable
  extend ActiveSupport::Concern

  # when we extend ActiveSupport::Concern, we can call 'included' instead of self.included(including_class)
  included do
    #  extend ClassMethods
    has_many :comments
  end
end