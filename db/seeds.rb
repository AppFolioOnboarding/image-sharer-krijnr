# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(0..19).each do |image_count|
  # rubocop:disable Layout/LineLength
  Image.create! path: "https://via.placeholder.com/#{(image_count % 2).positive? ? 300 : 500}x600?text=Placeholder+Image+#{image_count}", tag_list: "tag#{image_count}"
  # rubocop:enable Layout/LineLength
end
