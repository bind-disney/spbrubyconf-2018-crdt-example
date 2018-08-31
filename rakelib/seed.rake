require 'rake'
require 'hanami/rake_tasks'

namespace :seed do
  desc 'Export books to algolia service'
  task images: :environment do
    links = [
      'https://i.imgur.com/l3Q9Dz5.jpg',
      'https://i.imgur.com/mImqWPi.jpg',
      'https://i.imgur.com/1P7nifT.jpg',
      'https://i.imgur.com/rlCw6WE.jpg',
      'https://i.imgur.com/MlbyTiH.jpg',
      'https://i.imgur.com/ihlNZ3b.jpg'
    ]

    authors = [
      'Toht Ra',
      'Cikatro Vizago',
      'General Whorm Loathsom',
      'Baron Papanoida',
      'The Bendu',
      'Bossk'
    ]

    create_image = Container['operations.create_image']

    links.each do |link|
      authors.each do |author|
        create_image.call(image_params: { link: link, author: author })
      end
    end
  end
end
