# frozen_string_literal: true

class User < ApplicationRecord
  has_many :created_teams, class_name: "Team", foreign_key: "created_by_id"
  has_and_belongs_to_many :teams

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: %i[regular admin]
end
