module Api
  class FeedbacksController < ApplicationController
    def create
      feedback = Feedback.create feedback_params
      if feedback.errors.empty?
        render json: { data: feedback }, status: :created
      else
        render json: { errors: feedback.errors }, status: :unprocessable_entity
      end
    end

    private

    def feedback_params
      params.require(:feedback).permit(:name, :comments)
    end
  end
end
