ActiveAdmin.register Article do
  permit_params :body, :title, :author, :created_at, :updated_at

  config.per_page = 3
end
