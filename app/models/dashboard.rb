class Dashboard

    def total_article_word_count
        Article.total_word_count
    end

    def total_comment_word_count
        Comment.total_word_count
    end

    def article_count
        Article.count 
    end

    def comment_count
        Comment.count 
    end

    def most_popular_article
        Article.most_popular
    end

    def articles
        Article.order('created_at DESC').limit(5)
    end

    def comments
        Comment.order('created_at DESC').limit(5)
    end

    def total_word_count
        total_article_word_count + total_comment_word_count
    end

end