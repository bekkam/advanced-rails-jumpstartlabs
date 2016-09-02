class ArticleDecorator < Draper::Decorator
    delegate_all
    decorates_finders

    include IconLinkDecorations

    # attributes viewable based on type of user
    PUBLIC_ATTRIBUTES = [:title, :body, :created_at]
    ADMIN_ATTRIBUTES = [:title, :body, :created_at, :updated_at]

    # The object method here refers to the instance of Article that the decorator wraps.
    # For better semantics, the ArticleDecorator creates an alias for object named article. So we can replace object with article
    def formatted_created_at
        article.created_at.strftime("%m/%d/%Y - %H:%M")
    end

    def comments_count
        # method 'h' allows us to access all built in rails view helpers
        h.pluralize article.comments.count, "Comment"
    end

    def link(title)
        h.link_to article.title, h.article_path(article)
    end

    def to_json
        json = article.as_json
        h.current_user_is_admin? ? attributes = ADMIN_ATTRIBUTES : attributes = PUBLIC_ATTRIBUTES 
        attributes.map { |a| json[a.to_s]} 
    end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
