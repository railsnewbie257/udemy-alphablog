class Article < ActiveRecord::Base
  validates :title, presence: true, length: {minimum:3, maximum:20}
end