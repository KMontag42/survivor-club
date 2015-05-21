# == Schema Information
#
# Table name: second_chance_potentials
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  photo      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  gender     :string(255)
#
# vote winners:
# ["Vytas Baskauskas", "Cierra Eastin", "Peih-Gee Law", "Keith Nale",
# "Jeff Varner", "Kimmi Kappenberg", "Kelly Wiglesworth", "Shirin Oskooi",
# "Kelley Wentworth", "Monica Padilla", "Kass McQuillen", "Abi-Maria Gomes",
# "Andrew Savage", "Terry Deitz", "Woo Hwang", "Spencer Bledsoe", "Joe Anglim",
# "Jeremy Collins", "Tasha Fox", "Stephen Fishbach"]
class SecondChancePotential < ActiveRecord::Base

  has_many :second_chance_votes

end
