class TupFromPublication < Date
  
  def self.build(publication_str)
    tup                            = Tup.new
    tup.publication                = parse(publication_str)
    tup.opposition_start           = tup.publication + 1
    tup.theoretical_opposition_end = tup.publication + 30
    tup.opposition_end             = tup.theoretical_opposition_end.compute_opposition_end
    tup.legal_effect               = tup.opposition_end + 1
    tup
  end

  def compute_opposition_end
    day_off? ? next_business_day : self
  end
end
