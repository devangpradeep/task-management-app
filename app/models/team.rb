# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  has_and_belongs_to_many :users

  validates :title, presence: true
end
