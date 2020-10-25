class LegalEffectDate < Date
  attr_reader :publication, :publications, :opposition_start, :opposition_end, :legal_effect

  def self.find_key_dates(given_publication)
    key_dates = Tup.new
    key_dates.legal_effect = parse(given_publication)
    key_dates.opposition_end = key_dates.legal_effect - 1
    key_dates.publications = key_dates.opposition_end.compute_publication_dates

    if key_dates.publications.size == 1
      key_dates.publication = key_dates.publications.first
      key_dates.opposition_start = key_dates.publication + 1
    end
    key_dates
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
