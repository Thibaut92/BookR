import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "selectedInfo", "selectedId", "submitButton"]

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value.trim()
      if (query.length < 2) {
        this.resultsTarget.innerHTML = ""
        return
      }

      fetch(`/users/search?query=${encodeURIComponent(query)}&role=project_manager`)
        .then(response => response.json())
        .then(data => {
          this.resultsTarget.innerHTML = this.buildResultsHtml(data)
        })
    }, 300)
  }

  buildResultsHtml(projectManagers) {
    if (projectManagers.length === 0) {
      return '<div class="alert alert-info">Aucun maître d\'œuvre trouvé</div>'
    }

    return `
      <div class="row">
        ${projectManagers.map(pm => `
          <div class="col-md-6 mb-3">
            <div class="card project-manager-card" data-action="click->project-manager-search#select" data-id="${pm.id}">
              <div class="card-body">
                <h5 class="card-title">${pm.company_name}</h5>
                <p class="card-text">
                  <small class="text-muted">
                    ${pm.business_subcategory} - ${pm.company_type}<br>
                    SIRET: ${pm.siret}
                  </small>
                </p>
              </div>
            </div>
          </div>
        `).join('')}
      </div>
    `
  }

  select(event) {
    const card = event.currentTarget
    const projectManagerId = card.dataset.id
    const companyName = card.querySelector('.card-title').textContent

    this.selectedIdTarget.value = projectManagerId
    this.selectedInfoTarget.textContent = `${companyName}`
    this.submitButtonTarget.disabled = false
    this.resultsTarget.innerHTML = ""
    this.inputTarget.value = ""
  }

  clear() {
    this.inputTarget.value = ""
    this.resultsTarget.innerHTML = ""
    this.selectedInfoTarget.textContent = "Veuillez d'abord sélectionner un maître d'œuvre"
    this.selectedIdTarget.value = ""
    this.submitButtonTarget.disabled = true
  }
}
