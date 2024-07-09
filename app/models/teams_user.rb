# frozen_string_literal: true

class TeamsUser < ApplicationRecord
  has_many :created_tasks, class_name: "Task", foreign_key: "creator_id"
  has_many :assigned_to_tasks, class_name: "Task", foreign_key: "assigned_to_id"
end
