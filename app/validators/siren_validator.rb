class SirenValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /[0-9]{3}[\s\.\-]*[0-9]{3}[\s\.\-]*[0-9]{3}/.match?(value)
      record.errors[attribute] << (options[:message] || "Le siren doit être composé de neuf chiffres")
    end
  end
end
