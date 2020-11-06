class CompaniesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.first == value.last
      record.errors[attribute] << (options[:message] || "Les sociétés absorbée et absorbante doivent être distinctes.")

    elsif value.size != 2
      record.errors[attribute] << (options[:message] || "Il ne peut y avoir que deux sociétés participant à l'opération.")
    
    end

    if value.any? { |c| c.absorbed }
      record.errors[attribute] << (options[:message] || "#{value.find(&:absorbed).name} a déjà / fait l'objet d'une absorption.")
    end

    if value.where(absorbed: true).count > 1
      record.errors[attribute] << (options[:message] || "Il ne peut y avoir qu'une société absorbée.")
    end

    if value.where(merging: true).count > 1
      record.errors[attribute] << (options[:message] || "Il ne peut y avoir qu'une société absorbante.")
    end
  end
end
