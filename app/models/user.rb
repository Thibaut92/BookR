class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum :account_type, { admin: 0, industrial: 1, project_manager: 2, company: 3 }

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company_name, presence: true
  validates :siret, presence: true, uniqueness: true, length: { is: 14 }
  validates :phone, presence: true
  validates :account_type, presence: true
  validates :business_category, presence: true

  # Constantes pour les catégories d'entreprise
  BUSINESS_CATEGORIES = {
    'industrial' => [
      'Fabricant',
      'Distributeur',
      'Grossiste'
    ],
    'project_manager' => [
      'Architecte',
      'Bureau d\'études',
      'Maître d\'œuvre'
    ],
    'company' => [
      'Entreprise de construction',
      'Entreprise de rénovation',
      'Artisan'
    ]
  }
end
