# frozen_string_literal: true

class CreateTableTasks < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :status
      t.integer :priority
      t.references :category, null: false, foreign_key: true
      t.date :deadline
      t.references :creator, null: false, foreign_key: { to_table: :teams_users }
      t.references :assigned_to, null: false, foreign_key: { to_table: :teams_users }

      t.timestamps
    end
  end
end
