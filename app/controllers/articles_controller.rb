class ArticlesController < ApplicationController
  # TODO: move json display out of show
  # def show
  #   # @article = ArticleDecorator.find(params[:id])
  #   # show json in browser for admins
  #   @json = article.to_json
  # end

  def index
    articles, @tag = Article.search_by_tag_name(params[:tag])
    @articles = ArticleDecorator.decorate_collection(articles)
  end

  def create
    if article.attributes = (article_params)
      article.save
      flash[:notice] = "Article was created."
      redirect_to articles_path
    else
      render :new
    end
  end

  def update
    if article.update_attributes(article_params)
      flash[:notice] = "Article was updated."
      redirect_to article_path(article)
    else
      render :edit
    end
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    flash[:notice] = "#{article} was destroyed."
    redirect_to articles_path
  end

  # FIXME: there must be a less duplicative way to decorate both new and show articles..
  # use an instance variable (@cached_article) to memoize the object after the first request => better performance, reduces queries
  def article
    @cached_article ||= if params[:id]
      Article.find(params[:id])
      decorate_article(params[:id])
    else
      Article.new
    end
  end

  # incorporate decorator pattern
  def decorate_article(id)
    ArticleDecorator.find(id)
  end

  # expose article to view as a helper method
  helper_method :article

  private

  def article_params
    params.require(:article).permit(:title, :body, :author_id)
  end
  
end
