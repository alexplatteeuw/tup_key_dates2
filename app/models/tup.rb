class Tup < ApplicationRecord
  validates :publication, :opposition_start, :opposition_end, :legal_effect, presence: true
end
