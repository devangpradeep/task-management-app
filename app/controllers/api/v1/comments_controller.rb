# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :find_comment, only: %i[show update]
      def index
        comments = Comment.all
        render json: comments, status: :ok
      end

      def show
        render json: @comment, status: :ok
      end

      def create
        comment = Comment.new(comment_params)
        if comment.save
          render json: comment, status: :ok
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @comment.update(comment_params)
          render json: @comment, status: :ok
        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def find_comment
        @comment = Comment.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "Comment not found" }, status: :not_found
      end

      def comment_params
        params.require(:comment).permit(:user_id, :task_id, :data)
      end
    end
  end
end
