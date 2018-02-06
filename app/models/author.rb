class Author
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Search
  
  has_mongoid_attached_file :profile_pic
  validates_attachment_content_type :profile_pic, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :books

  field :name, type: String
  field :author_bio, type: String
  field :academics, type: String
  field :awards, type: String

  search_in :name
end
