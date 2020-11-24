# ADD DATES TO TUP
module Computable
  def compute(publication: false, legal_effect: false)
    new do |obj|
      # set TUP key dates from the selected publication
      if publication

        obj.publication                = Date.parse(publication)
        obj.opposition_start           = obj.publication + 1
        obj.theoretical_opposition_end = obj.publication + 30
        obj.opposition_end             = obj.theoretical_opposition_end.compute_opposition_end
        obj.legal_effect               = obj.opposition_end + 1

      # set TUP key dates from the selected legal effect
      elsif legal_effect

        obj.legal_effect       = Date.parse(legal_effect)
        obj.opposition_end     = obj.legal_effect - 1
        obj.publications       = obj.opposition_end.compute_publications
        if obj.publications.one?
          obj.publication      = obj.publications.first
          obj.opposition_start = obj.publication + 1
        end

      end
    end
  end
end

