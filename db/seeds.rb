# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Type.where(name: 'FASTA').first_or_create
Type.where(name: 'FASTAQ').first_or_create
Type.where(name: 'EMBL').first_or_create
Type.where(name: 'GCG').first_or_create
Type.where(name: 'GenBank').first_or_create
Type.where(name: 'IG').first_or_create
Type.where(name: 'Plain Sequence').first_or_create