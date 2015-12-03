ActiveAdmin.register Article do
  permit_params :body, :title, :author, :created_at, :updated_at

  config.per_page = 3

  controller do
    before_filter :set_article, only: [:show, :edit, :update, :destroy]

    def set_article
      @article = Article.where(slug: params[:id]).first
    end
  end
end
