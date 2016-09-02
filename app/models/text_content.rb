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

# 1. Factor out instance methods
# # app/models/text_content.rb

# module TextContent
#   def word_count
#     body.split.count
#   end
# end

# # Then can use it in our 2 classes:
# class Article < ActiveRecord::Base
#   include TextContent
# end

# class Comment < ActiveRecord::Base
#   include TextContent
# end
# ****** The include method adds any methods in the module as instance methods to the class ****

# 2. Factor out class methods
# # app/models/text_content.rb

# module WordCounter
#   def total_word_count
#     all.inject(0) {|total, a| total += a.word_count }
#   end
# end

# # Then can use it in our 2 classes:
# class Article < ActiveRecord::Base
#   #...
#   extend WordCounter
# end

# class Comment < ActiveRecord::Base
#   #...
#   extend WordCounter
# end

# **** we use extend to add the methods in the module as class methods to the extending class *****

# 3. Implement the same functionality in both class and instance methods
# # Issue: module instance methods called via 'include', but module class methods called via 'extend'
# # How can we write our module so we get both?

# Our module can define a self.included method, which takes a parameter that refers to the class which is including this module.
# This way, we can import the module using only'include', and still have a reference to the importing class

# module MyModule
#     # this method gets the class that is importing MyModule
#   def self.included(including_class)

#   end
# end

# In practice:
# # app/models/text_content.rb

# # instance method
# module TextContent
#   def word_count
#     body.split.count
#   end

# # Class method
#   module ClassMethods
#     def total_word_count
#       all.inject(0) {|total, a| total += a.word_count }
#     end
#   end
# # helper to get the class importing MyModule
#   def self.included(including_class)
#     # get the class that is importing MyModule, and extend it with ClassMethods
#     including_class.extend ClassMethods
#   end
# end


# 4. self.included and Associations
# # app/models/text_content.rb

# module TextContent
#   #...

#   def self.included(including_class)
#     including_class.extend ClassMethods
#     including_class.send(:has_one, :moderator_approval, {as: :content})
#   end
# end

# # above can be refactored - use class_eval when need to use self.included more than once
# module TextContent
#   #...

#   def self.included(including_class)
#     including_class.class_eval do
#       extend ClassMethods
#       has_one :moderator_approval, as: :content
#     end
#   end
# end




# 5. ActiveSupport::Concern - to improve syntax

# replaces 'self.included(including_class)' in:
#   def self.included(including_class)
#     including_class.extend ClassMethods
#     including_class.send(:has_one, :moderator_approval, {as: :content})
#   end
#  with 'include'

#  So result is:
#  module TextContent
#   extend ActiveSupport::Concern
#   included do
#     has_one :moderator_approval, as: :content
#   end
#   #...
# end

# 6. Final Refactor:


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

  # when we extend ActiveSupport::Concern, we can call 'included' instead of self.included(including_class)
  included do
    #  extend ClassMethods
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