class Tup < ApplicationRecord
  extend Computable

  before_save :set_companies_status
  before_destroy :update_companies_status

  has_many   :company_tups, dependent: :delete_all
  has_many   :companies, through: :company_tups

  serialize  :publications, Array

  validates  :publication, :opposition_start, :theoretical_opposition_end, presence: true, unless: :legal_effect?
  validates  :opposition_end, :legal_effect, presence: true
  validates  :companies, companies: true

  # check if there are several publication dates possible for a given legal effect (may only return true if compute_dates_from_legal_effect called)
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
