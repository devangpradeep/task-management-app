# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "TeamsUser"
  belongs_to :assigned_to, class_name: "TeamsUser"
  has_many :comments

  enum status: %i[back_log ready in_progress in_review completed]
  enum priority: %i[low medium high]
end
