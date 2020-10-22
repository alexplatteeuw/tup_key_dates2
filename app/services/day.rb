require 'holidays/core_extensions/date'

class Day < Date
  include Holidays::CoreExtensions::Date
  include ActiveModel::Validations

  attr_reader :opposition_end, :legal_effect, :publications, :results, :publication, :opposition_start

  validate :opposition_end_not_day_off

  def find_dates_from_publication
    @publication      = self
    @opposition_start = self + 1
    @opposition_end   = (self + 30).compute_opposition_end
    @legal_effect     = @opposition_end + 1
    self
  end

  def find_dates_from_legal_effect
    @legal_effect   = self
    @opposition_end = self - 1
    @publications   = @opposition_end.compute_publication_dates
    if @publications.size == 1
      @publication = @publications.first
      @opposition_start = @publication + 1
    end
    self
  end

  def is_a_day_off?
    holiday?(:fr) || saturday? || sunday? 
  end

  def compute_opposition_end
    is_a_day_off? ? next_business_day : self
  end

  def next_business_day 
    test_day = self.dup + 1
    test_day += 1 while test_day.is_a_day_off?
    test_day
  end

  def opposition_end_not_day_off
    if @opposition_end.is_a_day_off?
      error = "Le délai d'opposition des créancier ne peut expirer un samedi, un dimanche ou un jour férié."
      errors.add(:opposition_end, error)
    end
  end

  def compute_publication_dates
    publications = [self - 30]
    assumed_opposition_end = self.dup - 1
    while assumed_opposition_end.is_a_day_off?
      publications << assumed_opposition_end - 30
      assumed_opposition_end -= 1
    end
    publications.sort
  end
end

# strftime("%A")

