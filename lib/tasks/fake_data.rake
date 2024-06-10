namespace :fake_data do
  desc 'Generate fake products'
  task generate_products: :environment do
    require 'faker'

    puts 'Generating fake products...'

    25.times do
      Product.create!(
        name: Faker::Commerce.product_name,
        price: Faker::Commerce.price(range: 10.0..100.0),
        description: Faker::Lorem.paragraph(sentence_count: 2)
      )
    end

    puts '25 fake products generated.'
  end

  desc 'Associate fake images to products'
  task associate_images: :environment do
    puts 'Associating fake images to products...'

    Product.find_each do |product|
      file_path = Faker::LoremFlickr.image(search_terms: ['art'])
      product.image.attach(io: URI.open(file_path), filename: File.basename(URI.parse(file_path).path))

      puts "Image attached to product: #{product.name}"
    end
  end
end
