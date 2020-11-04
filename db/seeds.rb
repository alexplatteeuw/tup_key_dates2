# CREATION DE L'UTILISATEUR

puts "#{"=" * 128}"
puts ""
puts "CREATION D'UN UTILISATEUR ..."
puts ""

user = User.new
user.email    = 'aplatteeuw@outlook.fr'
user.password = '123456'
user.save!

puts "#{"-" * 19}USER#{"-" * 19}

      email    : #{User.first.email}
      password : 123456
      "

# CREATION DES SOCIETES

companies = [
  {
    name: 'Immoprêt France',
    headquarters: '37 boulevard Carnot 59000 Lille',
    share_capital: 179_980,
    siren: '502 647 142 R.C.S. Lille Métropole',
    legal_form: 'société par actions simplifiée',
    user: User.find(1)
  },
  {
    name: 'Invefi',
    headquarters: '37 boulevard Carnot 59000 Lille',
    share_capital: 4_500,
    siren: '492 485 768 R.C.S. Lille Métropole',
    legal_form: 'société à responsabilité limitée',
    user: User.find(1)
  },
  {
    name: 'Alto Informatique',
    headquarters: 'Immeuble Étoile Pleyel - 4 Allée de Seine - 93285 Saint-Denis Cedex',
    share_capital: 40_000,
    siren: '382 890 101 R.C.S. Bobigny',
    legal_form: 'société par actions simplifiée',
    user: User.find(1)
  },
  {
    name: 'JB Assur',
    headquarters: 'Immeuble Étoile Pleyel - 4 Allée de Seine - 93285 Saint-Denis Cedex',
    share_capital: 10_360.90,
    siren: '453 154 239 R.C.S. Bobigny',
    legal_form: 'société par actions simplifiée',    
    user: User.find(1)
  },
  {
    name: 'Hestia Holding',
    headquarters: "19 avenue de l'Opéra 75001 Paris",
    share_capital: 126_459_576,
    siren: '881 637 128 R.C.S. Paris',
    legal_form: 'société par actions simplifiée',    
    user: User.find(1)
  },
  {
    name: 'Financière Holding CEP',
    headquarters: "19 avenue de l'Opéra 75001 Paris",
    share_capital: 379_469_128,
    siren: '532 465 192 R.C.S. Paris',
    legal_form: 'société par actions simplifiée',    
    user: User.find(1)
  },
  {
    name: 'JB Holding',
    headquarters: "Immeuble Étoile Pleyel - 4 Allée de Seine - 93285 Saint-Denis Cedex",
    share_capital: 49_125,
    siren: '425 047 883 R.C.S. Bobigny',
    legal_form: 'société par actions simplifiée',    
    user: User.find(1)
  },
  {
    name: 'A.C.E.J.B.',
    headquarters: "Immeuble Étoile Pleyel - 4 Allée de Seine - 93285 Saint-Denis Cedex",
    share_capital: 76_875.48,
    siren: '402 704 514 R.C.S. Bobigny',
    legal_form: 'société par actions simplifiée',    
    user: User.find(1)
  }
]

puts "#{"=" * 128}"
puts ""
puts "CREATION DES SOCIETES ..."
puts ""

companies.each do |company|
  c               = Company.new
  c.name          = company[:name]
  c.headquarters  = company[:headquarters]
  c.share_capital = company[:share_capital]
  c.siren         = company[:siren]
  c.legal_form    = company[:legal_form]
  c.user          = company[:user]
  c.save!

  puts " #{"-" * 16}SOCIETE ##{Company.count}#{"-" * 16}

         Dénomination   :  #{c.name}
         Siège          :  #{c.headquarters}
         Capital social :  #{c.share_capital}
         Numéro siren   :  #{c.siren}
         Forme légale   :  #{c.legal_form}
         Utilisateur    :  #{c.user.email}
         "
end

# CREATION D'UNE TUP

puts "#{"=" * 128}"
puts ""
puts "CREATION D'UNE TUP ..."
puts ""

tup = Tup.build_from_publication('29/10/2020')

puts "#{"-" * 16}DATES CLES#{"-" * 16}

      Date de publication         : #{tup.publication}
      Début du délai d'opposition : #{tup.opposition_start}
      Fin du délai d'opppostion   : #{tup.opposition_end}
      Date d'effet légal          : #{tup.legal_effect}
      "
      
tup.companies = Company.find(1, 2)
tup.save!

puts "#{"-" * 11}SOCIETE PARTICIPANTES#{"-" * 10}


Absorbante : #{Tup.first.companies.where(merging: true).first.name}
Absorbée   : #{Tup.first.companies.where(absorbed: true).first.name}
"
  
