module FrenchDateHelper
  def to_little_endian(date)
    if date.is_a? Array
      date.map { |date| l(date, format: :default) }
    elsif date.is_a? Date
      l(date, format: :default)
    end
  end
end
