class Comment < ActiveRecord::Base
  belongs_to :article

  validates :article_id, :presence => true

  # add module with factored out functionality
  include TextContent

end
