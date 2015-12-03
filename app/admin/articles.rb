ActiveAdmin.register Article do
  permit_params :body, :title, :author, :created_at, :updated_at
end
