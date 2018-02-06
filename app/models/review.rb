class Review
  include Mongoid::Document
  include Mongoid::Search

  belongs_to :book

  field :reviewer, type: String
  field :rating, type: Integer
  field :title, type: String
  field :description, type: String

  def search_text
    [reviewer, title].join(' ')
  end

  search_in :search_text
end
