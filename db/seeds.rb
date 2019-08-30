# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.delete_all
Request.delete_all
Job.delete_all
JobTitlesSelection.delete_all

JobTitlesSelection.create({title_select: "Project Manager"})
JobTitlesSelection.create({title_select: "Project Coordinator"})
JobTitlesSelection.create({title_select: "Project Control Officer"})
JobTitlesSelection.create({title_select: "Project Analyst"})
JobTitlesSelection.create({title_select: "Analyst"})
JobTitlesSelection.create({title_select: "Research"})
JobTitlesSelection.create({title_select: "Product Manager"})
