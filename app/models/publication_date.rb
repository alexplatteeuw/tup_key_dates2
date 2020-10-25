class PublicationDate < Date
  attr_accessor :publication, :opposition_start, :potential_opposition_end, :opposition_end, :legal_effect
  
  def self.find_key_dates(given_publication)
    key_dates                          = Tup.new
    key_dates.publication              = PublicationDate.parse(given_publication)
    key_dates.opposition_start         = key_dates.publication + 1
    key_dates.potential_opposition_end = key_dates.publication + 30
    key_dates.opposition_end           = key_dates.potential_opposition_end.compute_opposition_end
    key_dates.legal_effect             = key_dates.opposition_end + 1
    key_dates
  end

  def compute_opposition_end
    day_off? ? next_business_day : self
  end
end
