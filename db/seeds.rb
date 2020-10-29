  user = User.new
  user.email    = 'aplatteeuw@outlook.fr'
  user.password = '123456'
  user.save!

  puts "___________________________________________________________________________________________________________________________"
  puts "One user created (#{user}) with the following email address: #{user.email} & password: #{user.password}"
  puts "___________________________________________________________________________________________________________________________"

companies = [
  {
    name: 'Invefi',
    headquarters: '37 boulevard Carnot 59000 Lille',
    share_capital: 4_500,
    siren: '492 485 768 R.C.S. Lille Métropole',
    legal_form: 'société à responsabilité limitée',
    user: User.find(1)
  },
  {
    name: 'Immoprêt France',
    headquarters: '37 boulevard Carnot 59000 Lille',
    share_capital: 179_980,
    siren: '502 647 142 R.C.S. Lille Métropole',
    legal_form: 'société par actions simplifiée',
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
  }
]

# puts "Now creating companies ..."

# companies.each do |company|
#   c               = Company.new
#   c.name          = company[:name]
#   c.headquarters  = company[:headquarters]
#   c.share_capital = company[:share_capital]
#   c.siren         = company[:siren]
#   c.legal_form    = company[:legal_form]
#   c.user          = company[:user]
#   c.save!

#   puts " ............................................................................................
#          company ##{Company.count}

#          name:          #{c.name}
#          headquarters:  #{c.headquarters}
#          share_capital: #{c.share_capital}
#          siren:         #{c.siren}
#          legal_form:    #{c.legal_form}
#          user:          #{c.user}"
# end

puts "___________________________________________________________________________________________________________________________"
puts "Now creating one TUP..."

tup = Tup.build_from_publication('29/10/2020')

puts "............................................................................................
      publication:      #{tup.publication}
      opposition start: #{tup.opposition_start}
      opposition end:   #{tup.opposition_end}
      legal effect:     #{tup.legal_effect}"
      puts "___________________________________________________________________________________________________________________________"
      
      # absorbante = Company.find(1)
      # absorbee   = Company.find(2)
      
      # absorbante.tup = tup
      # absorbante.save!
      
      # absorbee.tup = tup
      # absorbee.save!

      tup.companies.build([companies.first, companies.last])
      
      tup.save!
      
puts "............................................................................................
      Les sociétés participant à l'opération sont les suivantes: #{Tup.first.companies.first.name} & #{Tup.first.companies.last.name}"
puts "___________________________________________________________________________________________________________________________"
