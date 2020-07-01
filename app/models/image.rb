class Image < ApplicationRecord
  validates :path, presence: true, format: URI.regexp(%w[http https])
end
