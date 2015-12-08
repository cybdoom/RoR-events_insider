namespace :db do
  namespace :articles do
    desc 'Generates slug for each article in db'
    task generate_slugs: :environment do
      Article.update_all slug: nil
      Article.all.each &:update_slug
    end
  end
end
