require 'holidays/core_extensions/date'

class Date
  include Holidays::CoreExtensions::Date

  attr_reader :publication, :publications, :opposition_start, :opposition_end, :legal_effect

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

  def include_many_publications?
    @publications&.(size > 1)
  end

  def include_valid_opposition_end?
    @opposition_end.business_day?
  end

  def has_not_valid_opposition_end?
    !has_valid_opposition_end
  end

  def day_off?
    holiday?(:fr) || saturday? || sunday? 
  end

  def business_day?
    !day_off? 
  end

  def compute_opposition_end
    day_off? ? next_business_day : self
  end

  def next_business_day 
    test_day = self.dup + 1
    test_day += 1 while test_day.day_off?
    test_day
  end

  def compute_publication_dates
    publications = [self - 30]
    assumed_opposition_end = self.dup - 1
    while assumed_opposition_end.day_off?
      publications << assumed_opposition_end - 30
      assumed_opposition_end -= 1
    end
    publications.sort
  end
end
