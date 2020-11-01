class Tup < ApplicationRecord
  has_many   :companies
  serialize  :publications, Array
  validates  :publication, :opposition_start, :theoretical_opposition_end, presence: true, unless: :legal_effect?
  validates  :opposition_end, :legal_effect, presence: true
  validate   :has_two_companies, :has_different_companies, :has_no_running_tup

  def self.build_from_legal_effect(date)
    Tup.new do |t|
      begin
        Date.parse(date)
      rescue ArgumentError
        t.errors.add(:legal_effect, "La date renseignée n'est pas dans un format valide")
      else
        t.legal_effect       = Date.parse(date)
        t.opposition_end     = t.legal_effect - 1
        t.publications       = t.opposition_end.compute_publications
        if t.publications.one?
          t.publication      = t.publications.first
          t.opposition_start = t.publication + 1
        end
      end
    end
  end
  
  def self.build_from_publication(date)
    Tup.new do |t|
      begin
        Date.parse(date)
      rescue ArgumentError
        t.errors.add(:publication, "La date renseignée n'est pas dans un format valide")
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

  def has_two_companies
    unless companies.size == 2
      errors.add(:companies, "Il manque une absorbée et une absorbante")
    end
  end

  def has_different_companies
    if companies.first == companies.last
      errors.add(:companies, "Les sociétés doivent être différentes")
    end
  end

  def has_no_running_tup
    if Company.find(companies.first.id).tup || Company.find(companies.last.id).tup
      errors.add(:companies, "Opération de TUP déjà en cours")
    end
  end
end
