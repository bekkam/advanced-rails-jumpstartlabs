class DashboardController < ApplicationController
  def show
    # @articles             = Article.for_dashboard
    # @article_count        = Article.count
    # @article_word_count   = Dashboard.new.total_word_count
    # @most_popular_article = Article.most_popular

    # @comments           = Comment.for_dashboard
    # @comment_count      = Comment.count
    # @comment_word_count = Dashboard.new.total_word_count
    @dashboard          = Dashboard.new
  end
end
