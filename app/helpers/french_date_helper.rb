module FrenchDateHelper
  def french_date(date)
    date.strftime("%d/%m/%Y")
  end
end
