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
end
