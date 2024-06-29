# frozen_string_literal: true

module Api
  module V1
    class TeamsController < ApplicationController
      before_action :find_team, only: %i[show update users add_user remove_user]
      def index
        teams = Team.all
        render json: teams, status: :ok
      end

      def show
        render json: @team, status: :ok
      end

      def create
        team = Team.new(team_params)
        if team.save
          render json: team, status: :ok
        else
          render json: { errors: team.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @team.update(team_params)
          render json: @team, status: :ok
        else
          render json: { errors: @team.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def users
        render json: @team.users, status: :ok
      end

      def add_user
        if @team.users << User.find(params[:user_id])
          render json: { message: "User added successfully" }, status: :ok
        else
          render json: { errors: @team.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotUnique
        render json: { errors: "User already added to the team" }, status: :unprocessable_entity
      end

      def remove_user
        if @team.users.delete(User.find(params[:user_id]))
          render json: { message: "User removed successfully" }, status: :ok
        else
          render json: { errors: @team.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def find_team
        @team = Team.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "Team not found!" }, status: :not_found
      end

      def team_params
        params.require(:team).permit(:title, :description, :created_by_id)
      end
    end
  end
end
