# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Nettoyage de la base de données
puts "Cleaning database..."
Meeting.destroy_all
User.destroy_all

# Création des utilisateurs
puts "Creating users..."

industrial = User.create!(
  email: "industrial@example.com",
  password: "password",
  company_name: "Industrial Corp",
  siret: "12345678901234",
  phone: "0123456789",
  account_type: "industrial",
  business_subcategory: "manufacturing",
  company_type: "corporation"
)

project_manager = User.create!(
  email: "pm@example.com",
  password: "password",
  company_name: "PM Solutions",
  siret: "98765432109876",
  phone: "0987654321",
  account_type: "project_manager",
  business_subcategory: "construction",
  company_type: "corporation"
)

# Création des meetings
puts "Creating meetings..."

# Meeting pour aujourd'hui
Meeting.create!(
  industrial: industrial,
  project_manager: project_manager,
  start_time: Time.current.beginning_of_day + 10.hours,
  end_time: Time.current.beginning_of_day + 11.hours,
  status: "pending",
  notes: "Discussion initiale",
  location: "Paris",
  meeting_type: "initial"
)

# Meeting pour demain
Meeting.create!(
  industrial: industrial,
  project_manager: project_manager,
  start_time: Time.current.tomorrow.beginning_of_day + 14.hours,
  end_time: Time.current.tomorrow.beginning_of_day + 15.hours,
  status: "accepted",
  notes: "Suivi de projet",
  location: "Lyon",
  meeting_type: "followup"
)

# Meeting pour la semaine prochaine
Meeting.create!(
  industrial: industrial,
  project_manager: project_manager,
  start_time: Time.current.next_week + 9.hours,
  end_time: Time.current.next_week + 10.hours,
  status: "pending",
  notes: "Présentation finale",
  location: "Marseille",
  meeting_type: "presentation"
)

puts "Finished! Created:"
puts "- #{User.count} users"
puts "- #{Meeting.count} meetings"
