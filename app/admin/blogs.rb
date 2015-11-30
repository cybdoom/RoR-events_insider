ActiveAdmin.register Blog do
  permit_params :title, :description, :author, :created_at, :updated_at
  menu priority: 9
end
