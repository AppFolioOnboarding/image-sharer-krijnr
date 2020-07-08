require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should return feedback on success' do
    assert_difference 'Feedback.count', 1 do
      post api_feedbacks_path, params: { feedback: { name: 'asd', comments: 'adasd asdasd' } }
    end
    assert_response :created
    json_response = JSON.parse response.body
    assert_equal 1, json_response['data']['id']
    assert_equal 'asd', json_response['data']['name']
    assert_equal 'adasd asdasd', json_response['data']['comments']
  end

  test 'should return errors on missing name' do
    assert_no_difference 'Feedback.count' do
      post api_feedbacks_path, params: { feedback: { comments: 'adasd asdasd' } }
    end
    assert_response :unprocessable_entity
    json_response = JSON.parse response.body
    assert_equal({ 'errors' => { 'name' => ["can't be blank"] } }, json_response)
  end

  test 'should return errors on missing comment' do
    assert_no_difference 'Feedback.count' do
      post api_feedbacks_path, params: { feedback: { name: 'adasd asdasd' } }
    end
    assert_response :unprocessable_entity
    json_response = JSON.parse response.body
    assert_equal({ 'errors' => { 'comments' => ["can't be blank"] } }, json_response)
  end
end
