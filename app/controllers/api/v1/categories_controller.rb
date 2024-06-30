# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :find_category, only: %i[show update]
      def index
        categories = Category.all
        render json: categories, status: :ok
      end

      def show
        render json: @category, status: :ok
      end

      def create
        category = Category.new(category_params)
        if category.save
          render json: cantegory, status: :ok
        else
          render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: @category, status: :ok
        else
          render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def find_category
        @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "Category not found" }, status: :not_found
      end

      def category_params
        params.require(:category).permit(:title, :description)
      end
    end
  end
end
