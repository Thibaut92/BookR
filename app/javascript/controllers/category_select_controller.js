import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["subcategorySelect"]

  connect() {
    this.subcategories = {
      'industrial': [
        'Fabricant de matériaux',
        'Fabricant de menuiseries',
        'Fabricant de revêtements',
        'Fabricant d\'équipements',
        'Fabricant de mobilier',
        'Fabricant d\'outillage'
      ],
      'project_manager': [
        'Architecte',
        'Bureau d\'études',
        'Économiste de la construction',
        'Conducteur de travaux',
        'Maître d\'œuvre indépendant',
        'Cabinet d\'architecture'
      ],
      'company': [
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
  }

  updateSubcategories(event) {
    const accountType = event.target.value
    const subcategories = this.subcategories[accountType] || []
    
    this.subcategorySelectTarget.innerHTML = '<option value="">Sélectionnez votre profession</option>'
    subcategories.forEach(subcategory => {
      this.subcategorySelectTarget.innerHTML += `<option value="${subcategory}">${subcategory}</option>`
    })
  }
}
