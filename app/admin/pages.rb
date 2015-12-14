ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  controller do
    before_filter :set_page, only: [:show, :edit, :update, :destroy]

    def set_page
      @page = Page.where(slug: params[:id]).first
    end
  end
end
