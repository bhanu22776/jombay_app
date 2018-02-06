class Book
  include Mongoid::Document
  include Mongoid::Search

  has_many :reviews
  belongs_to :author

  field :name, type: String
  field :short_description, type: String
  field :long_description, type: String
  field :chapter_index, type: Integer
  field :publication_date, type: Date
  field :genre, type: Array

  def search_text
    [name, genre].join(' ')
  end

  search_in :search_text
end
