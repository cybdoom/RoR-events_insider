namespace :db do
  namespace :articles do
    desc 'Generates slug for each article in db'
    task :generate_slugs do
      Article.each &:generate_slug
    end
  end
end
