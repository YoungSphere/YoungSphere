module Api
  module V1
    class CommentsController < ActionController::API
      before_action :authenticate_user!

      def create
        @comment = @commentable.comments.new comment_params
        @comment.user = current_user
        @comment.save
        render json: @commentable
      end

      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors
        end
      end
      def destroy
        @comment.destroy
        head :no_content
      end
      private

      def comment_params
        params.require(:comment).permit(:body)
      end
    end

  end
end
