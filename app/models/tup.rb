class Tup < ApplicationRecord
  validates :publication, :opposition_start, :opposition_end, :legal_effect, presence: true
  validate :legal_effect_after_day_off
  
  private
  
  def legal_effect_after_day_off
    return if legal_effect.blank?
    if (legal_effect - 1).is_a_day_off?
      errors.add(:legal_effect, "ne peut pas être ce jour-là")
    end
  end
end
