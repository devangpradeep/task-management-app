# frozen_string_literal: true

class AddIdToTeamsUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :teams_users, :id, :primary_key
  end
end
