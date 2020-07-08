class Image < ApplicationRecord
  validates :path, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  acts_as_taggable_on :tags
end
