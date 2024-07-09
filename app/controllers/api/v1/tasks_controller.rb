# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :find_task, only: %i[show update]

      def index
        tasks = Task.all
        render json: tasks, status: :ok
      end

      def show
        render json: @task, status: :ok
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: task, status: :ok
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def find_task
        @task = Task.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "Task not found" }, status: :not_found
      end

      def task_params
        params.require(:task).permit(:title, :description, :status, :priority, :category_id, :deadline, :creator_id,
                                     :assigned_to_id)
      end
    end
  end
end
