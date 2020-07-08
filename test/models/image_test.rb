require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'create image' do
    image = Image.create path: 'http://www.nope.com/not/a/real/image/image.png'
    assert image.valid?
  end
  test 'create invalid image' do
    image = Image.create
    assert image.invalid?
  end
  test 'create image with invalid URI scheme' do
    image = Image.create path: 'ftp://not/a/url'
    assert image.invalid?
  end
  test 'create image with incomplete URL' do
    image = Image.create path: 'image.jpg'
    assert image.invalid?
  end
end
