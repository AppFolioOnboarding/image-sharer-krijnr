require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    img = Image.create! path: 'https://www.demo.com/image.jpg'
    assert img.valid?, 'image should be valid'
    get image_path(img)
    assert_response :success
  end

  test 'should get show with 2 tags' do
    img = Image.create! path: 'https://www.demo.com/image-with-2-tags.jpg', tag_list: 'tag_1, tag_2'
    get image_path(img)
    assert_response :success
    assert_select '.js-tag-list', 2
  end

  test 'should get create' do
    assert_difference 'Image.count', 1 do
      post images_url, params: { image: { path: 'https://www.demo.com/image2.jpg' } }
    end
    assert_equal 'https://www.demo.com/image2.jpg', Image.last.path
    assert_redirected_to image_path(Image.last)
  end

  test 'should accept tags on image create' do
    assert_difference 'Image.count', 1 do
      post images_url, params: { image: { path: 'https://www.demo.com/image6.jpg', tag_list: 'tag_1 , tag_2' } }
    end
    assert_equal 'https://www.demo.com/image6.jpg', Image.last.path
    assert_redirected_to image_path(Image.last)
    assert_equal 2, Image.last.tags.count
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

  test 'should list all images, with tags' do
    Image.create! path: 'https://www.demo.com/image3.jpg'
    Image.create! path: 'https://www.demo.com/image4.jpg', tag_list: 'tag_c, tag_d'
    Image.create! path: 'https://www.demo.com/image5.jpg'
    get images_url
    assert_response :success
    assert_select '.js-image-list', 3
    assert_select '.js-tag-list', 2
  end

  test 'images are sorted descending' do
    Image.create! path: 'https://www.demo.com/image0.jpg'
    Image.create! path: 'https://www.demo.com/image1.jpg'
    Image.create! path: 'https://www.demo.com/image2.jpg'

    get images_url

    assert_select '.js-image-list' do
      assert_select 'img' do |images|
        assert images[0].to_s.include? 'https://www.demo.com/image2.jpg'
        assert images[1].to_s.include? 'https://www.demo.com/image1.jpg'
        assert images[2].to_s.include? 'https://www.demo.com/image0.jpg'
      end
    end
  end

  test 'should list all images with specific tag only' do
    Image.create! path: 'https://www.demo.com/image3.jpg', tag_list: 'tag_b, tag_d'
    Image.create! path: 'https://www.demo.com/image4.jpg', tag_list: 'tag_c, tag_d'
    Image.create! path: 'https://www.demo.com/image5.jpg', tag_list: 'tag_b'
    get images_url, params: { tag_filter: 'tag_b' }
    assert_response :success
    assert_select '.js-image-list', 2
    assert_select '.js-tag-list' do |tags|
      assert tags[0].to_s.include? 'tag_b'
      assert tags[1].to_s.include? 'tag_b'
      assert tags[2].to_s.include? 'tag_d'
      assert_equal images_path(tag_filter: 'tag_b'), tags[0][:href]
    end
  end

  test 'should delete an image' do
    Image.create! path: 'https://www.demo.com/image3.jpg'
    @image = Image.create! path: 'https://www.demo.com/image4.jpg', tag_list: 'tag_c, tag_d'
    Image.create! path: 'https://www.demo.com/image5.jpg'

    assert_difference 'Image.count', -1 do
      delete image_path(@image)

      assert_equal 'Image deleted', flash[:notice]
      assert_redirected_to images_url
    end
  end
end
