namespace :db do
  namespace :articles do
    desc 'Generates slug for each article in db'
    task generate_slugs: :environment do
      Article.all.each &:generate_slug
    end
  end
end
