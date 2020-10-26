module KeyDatesHelper
  def display_time_extension_warning(tup)
    str = ""
    str << "Le délai d'opposition expirant le #{l(tup.theoretical_opposition_end, format: :long)}, " 
    str << "qui est un #{insert_kind_of_day_off(tup.theoretical_opposition_end)}, "
    str << "celui-ci est prorogé au prochain jour ouvré soit le #{l(tup.opposition_end, format: :long)}."
  end
  
  def display_legal_effect_warning(tup)
    str = "" 
    str << "Une date d'effet le #{l(tup.legal_effect, format: :long)} suppose que le délai d'opposition des créanciers expire le #{l(tup.opposition_end, format: :long)}, "
    str << "qui est un #{insert_kind_of_day_off(tup.opposition_end)}. "
    str << "Le délai d'opposition des créancier ne peut expirer un samedi, un dimanche ou un jour férié."
  end
  
  def insert_kind_of_day_off(date)
    if date.saturday? || date.sunday?
      l(date, format: "%A")
    elsif date.holiday?(:fr)
      "jour férié"
    end
  end
end








