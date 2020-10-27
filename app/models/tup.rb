class Tup < ApplicationRecord
  serialize :publications, Array
  validates :publication, :opposition_start, :theoretical_opposition_end, presence: true, unless: :legal_effect?
  validates :opposition_end, :legal_effect, presence: true
  
  def self.build_from_legal_effect(date)
    Tup.new do |t|
      t.legal_effect       = Date.parse(date)
      t.opposition_end     = t.legal_effect - 1
      t.publications       = t.opposition_end.compute_publications
      if t.publications.one?
        t.publication      = t.publications.first
        t.opposition_start = t.publication + 1
      end
    end
  end
  
  def self.build_from_publication(date)
    Tup.new do |t|
      begin
        Date.parse(date)
      rescue ArgumentError => e
        t.errors.add(:legal_effect, message: e)
      else
        t.publication                = Date.parse(date)
        t.opposition_start           = t.publication + 1
        t.theoretical_opposition_end = t.publication + 30
        t.opposition_end             = t.theoretical_opposition_end.compute_opposition_end
        t.legal_effect               = t.opposition_end + 1
      end
    end
  end

  def publications?
    publications && publications.size > 1
  end
end
