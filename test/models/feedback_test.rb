require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'validates name and comments present' do
    feedback = Feedback.new name: 'Krijn van der Raadt', comments: 'This test rocks'
    assert feedback.valid?
  end

  test 'name is required' do
    feedback = Feedback.new comments: 'test'
    assert_predicate feedback, :invalid?
  end

  test 'comments is required' do
    feedback = Feedback.new name: 'test'
    assert_predicate feedback, :invalid?
  end
end
