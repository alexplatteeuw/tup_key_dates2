class Tup < ApplicationRecord
  before_save :set_companies_status
  before_destroy :update_companies_status

  has_many   :company_tups, dependent: :delete_all
  has_many   :companies, through: :company_tups

  serialize  :publications, Array

  validates  :publication, :opposition_start, :theoretical_opposition_end, presence: true, unless: :legal_effect?
  validates  :opposition_end, :legal_effect, presence: true
  validates  :companies, companies: true

  # ADD DATES TO TUP
  # set TUP key dates from the selected publication
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
  # set TUP key dates from the selected legal effect
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

  # check if there are several publication dates possible for a given legal effect (may only return true if build_from_legal_effect called)
  def publications?
    publications && publications.size > 1
  end

  private

  # CALLBACKS

  # on TUP creation
  def set_companies_status
    companies.first.merging = companies.last.absorbed = true
  end

  # on TUP deletion
  def update_companies_status
    merging_company  = companies.find_by(merging: true)
    absorbed_company = companies.find_by(absorbed: true)
    merging_company.update(merging: false) unless merging_company.tups.count >= 2
    absorbed_company.update(absorbed: false)
  end
end
