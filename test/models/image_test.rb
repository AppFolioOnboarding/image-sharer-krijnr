require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'create image' do
    image = Image.create path:'/not/a/real/image'
    assert image.valid?
  end
  test 'create invalid image' do
    image = Image.create 
    assert image.invalid?
  end
end
