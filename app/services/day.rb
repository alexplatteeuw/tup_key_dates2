require 'holidays/core_extensions/date'

class Day < Date
  include Holidays::CoreExtensions::Date

  def find_dates_from_publication
    @results                    = {}
    opposition_end              = self + 30
    @results[:publication]      = self
    @results[:opposition_start] = self + 1
    @results[:opposition_end]   = opposition_end.is_a_day_off? ? opposition_end.next_business_day : opposition_end
    @results[:legal_effect]     = @results[:opposition_end] + 1
    @results
  end

  def find_dates_from_legal_effect
    @results                  = {}
    @results[:legal_effect]   = self
    @results[:opposition_end] = (self - 1).compute_opposition_end
    @results[:publications]   = (self - 1).compute_publication_dates
    @results
  end

  def is_a_day_off?
    holiday?(:fr) || saturday? || sunday? 
  end

  def next_business_day 
    test_day = self.dup + 1
    test_day += 1 while test_day.is_a_day_off?
    test_day
  end

  def compute_opposition_end
    is_a_day_off? ? next_business_day : self
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


