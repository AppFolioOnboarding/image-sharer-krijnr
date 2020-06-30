require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test 'should get index' do
    get root_path
    assert_select 'blink'
  end
end
