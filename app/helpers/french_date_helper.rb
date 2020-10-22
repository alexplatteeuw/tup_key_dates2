module FrenchDateHelper
  def french_date(date)
    if date.is_a? Array
      date.map { |date| date.strftime("%d/%m/%Y") }
    elsif date.is_a? Day
      date.strftime("%d/%m/%Y")
    end
  end
end
