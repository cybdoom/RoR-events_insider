ActiveAdmin.register Article do
  permit_params :body, :title, :author, :created_at, :updated_at

  config.per_page = 3

  form do |f|
    inputs do
      f.input :title
      f.input :author
      f.input :body, :rows => 40, :cols => 120, class: 'tinymce'
    end
    actions
  end


  controller do
    before_filter :set_article, only: [:show, :edit, :update, :destroy]

    def set_article
      @article = Article.where(slug: params[:id]).first
    end
  end
end
