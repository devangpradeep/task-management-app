# frozen_string_literal: true

class CreateJoinTableUsersTeams < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :teams do |t|
      t.index %i[user_id team_id], unique: true
      t.index %i[team_id user_id]
      t.timestamps
    end
  end
end
