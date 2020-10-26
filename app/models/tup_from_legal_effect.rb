class TupFromLegalEffect < Date
  
  def self.build(legal_effect_str)
    tup                = Tup.new
    tup.legal_effect   = parse(legal_effect_str)
    tup.opposition_end = tup.legal_effect - 1
    tup.publications   = tup.opposition_end.compute_publications
    if tup.publications.one?
      tup.publication      = tup.publications.first
      tup.opposition_start = tup.publication + 1
    end
    tup
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
end
