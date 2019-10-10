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

StandardJobTitle.create({job_title: "Project Manager"})
StandardJobTitle.create({job_title: "Project Coordinator"})
StandardJobTitle.create({job_title: "Project Control Officer"})
StandardJobTitle.create({job_title: "Project Analyst"})
StandardJobTitle.create({job_title: "Investment Analyst"})
StandardJobTitle.create({job_title: "Analyst"})
StandardJobTitle.create({job_title: "Research"})
StandardJobTitle.create({job_title: "Product Manager"})

