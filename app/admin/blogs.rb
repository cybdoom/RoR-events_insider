ActiveAdmin.register Blog do
  permit_params :title, :description
  menu priority: 9
end
