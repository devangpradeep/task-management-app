# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, only: %i[show update teams]
      def index
        render json: User.all, status: :ok
      end

      def show
        render json: @user, status: :ok
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def teams
        render json: @user.teams, status: :ok
      end

      private

      def find_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      def user_params
        params.require(:user).permit(:name, :email, :role)
      end
    end
  end
end
