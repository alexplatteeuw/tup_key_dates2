class Company < ApplicationRecord
  SIREN_FORMAT = /[0-9]{3}[\s\.\-]*[0-9]{3}[\s\.\-]*[0-9]{3}/
  
  belongs_to :user

  before_save :normalize_siren
  before_destroy :delete_associated_tups

  has_many :company_tups, dependent: :delete_all
  has_many :tups, through: :company_tups

  validates :name, :siren, :headquarters, :legal_form, :share_capital, presence: true
  validates :siren, siren: true

  # CALLBACKS

  # normalize siren before saving it to database
  def normalize_siren
    self.siren = SIREN_FORMAT.match(self.siren)[0].gsub(/\W/, '')
  end

  # delete every TUP attached to the company when the company is deleted
  def delete_associated_tups
    tups.each(&:destroy)
  end
end
