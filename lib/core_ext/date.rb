require 'holidays/core_extensions/date'

class Date
  include Holidays::CoreExtensions::Date

  def day_off?
    holiday?(:fr) || saturday? || sunday? 
  end

  def business_day?
    !day_off? 
  end
  
  def next_business_day 
    test_day = self.dup + 1
    test_day += 1 while test_day.day_off?
    test_day
  end

  def compute_publications
    publications           = [self - 30]
    assumed_opposition_end = self.dup - 1
    while assumed_opposition_end.day_off?
      publications << assumed_opposition_end - 30
      assumed_opposition_end -= 1
    end
    publications.sort
  end

  def compute_opposition_end
    day_off? ? next_business_day : self
  end
end
