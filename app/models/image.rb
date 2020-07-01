class Image < ApplicationRecord
    validates :path, presence: true
end
