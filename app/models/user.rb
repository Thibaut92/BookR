class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum :account_type, { admin: 0, industrial: 1, project_manager: 2, company: 3 }

  # Relations
  has_many :meetings_as_industrial, class_name: 'Meeting', foreign_key: 'industrial_id'
  has_many :meetings_as_project_manager, class_name: 'Meeting', foreign_key: 'project_manager_id'

  # Validations
  validates :company_name, presence: true
  validates :siret, presence: true, uniqueness: true, length: { is: 14 }
  validates :phone, presence: true
  validates :account_type, presence: true
  validates :business_subcategory, presence: true
  
  # Constants pour les sous-catégories par type de compte
  SUBCATEGORIES = {
    'industrial' => [
      'Fabricant de matériaux',
      'Fabricant de menuiseries',
      'Fabricant de revêtements',
      'Fabricant d\'équipements',
      'Fabricant de mobilier',
      'Fabricant d\'outillage'
    ],
    'project_manager' => [
      'Architecte',
      'Bureau d\'études',
      'Économiste de la construction',
      'Conducteur de travaux',
      'Maître d\'œuvre indépendant',
      'Cabinet d\'architecture'
    ],
    'company' => [
      'Entreprise de maçonnerie',
      'Entreprise de plomberie',
      'Entreprise d\'électricité',
      'Entreprise de peinture',
      'Entreprise de menuiserie',
      'Entreprise de carrelage',
      'Entreprise de sols souples',
      'Entreprise de plâtrerie',
      'Entreprise de couverture',
      'Entreprise de façade',
      'Entreprise de terrassement',
      'Entreprise de démolition'
    ]
  }

  # Callbacks
  before_validation :validate_siret_with_api, if: :siret_changed?

  private

  def validate_siret_with_api
    # TODO: Implement SIRENE API validation
    true
  end
end
