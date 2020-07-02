require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    img = Image.create! path: 'https://www.demo.com/image.jpg'
    assert img.valid?, 'image should be valid'
    get image_path(img)
    assert_response :success
  end

  test 'should get create' do
    assert_difference 'Image.count', 1 do
      post images_url, params: { image: { path: 'https://www.demo.com/image2.jpg' } }
    end
    assert_equal 'https://www.demo.com/image2.jpg', Image.last.path
    assert_redirected_to image_path(Image.last)
  end

  test 'failed to create image' do
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { path: 'asd asd' } }
    end
    assert_response 422
    assert_select 'h1', 'New Image'
  end

  test 'should get new' do
    get new_image_url
    assert_response :success
    assert_select 'h1', 'New Image'
  end
end
