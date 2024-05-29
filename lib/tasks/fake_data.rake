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
end
