# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :tasks

  validates :title, presence: true
end
