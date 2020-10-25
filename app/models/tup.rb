class Tup < ApplicationRecord
  attr_accessor :publications
  validates :publication, :opposition_start, :opposition_end, :legal_effect, presence: true
end
