class Tup < ApplicationRecord
  validates :opposition_end, :legal_effect, :publication, :opposition_start, presence: true
end
