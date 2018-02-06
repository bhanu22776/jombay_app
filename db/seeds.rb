# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

genre_list = ["science fiction", "satire", "drama", "action and adventure", "romance", "mystery", "horror", "self help", "fantasy"] 
1000.times do
	author = Author.create(name: Faker::Book.author, author_bio: Faker::Lorem.paragraph, academics: Faker::Lorem.paragraph, awards: Faker::Lorem.paragraph)
	puts "********************  #{author.name}  ********************"
	5.times do
		book = author.books.create(name: Faker::Book.title, short_description: Faker::Lorem.sentence, long_description: Faker::Lorem.paragraph, chapter_index: rand(100), publication_date: Faker::Date.between(2.year.ago, 1.year.ago), genre: genre_list.sample(3))
		puts "********************  #{book.name}  ********************"
		5.times do
			book.reviews.create(reviewer: Faker::Name.name, rating: rand(5), title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
			puts "review added for #{book.name} book."
		end
	end
end
