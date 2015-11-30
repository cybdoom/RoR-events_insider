ActiveAdmin.register Article do
  permit_params :body, :title, :created_at, :updated_at
end
