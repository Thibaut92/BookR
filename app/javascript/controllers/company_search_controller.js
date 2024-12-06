import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  static targets = ["input", "companyName", "siret"]

  connect() {
    this.tomSelect = new TomSelect(this.inputTarget, {
      valueField: 'siret',
      labelField: 'display_name',
      searchField: ['company_name', 'siret'],
      load: (query, callback) => this.loadOptions(query, callback),
      render: {
        option: (item) => {
          return `<div>
            <div class="font-weight-bold">${item.company_name}</div>
            <div class="text-muted">SIRET: ${item.siret}</div>
            <div class="text-muted small">${item.address}</div>
          </div>`
        }
      },
      onChange: (siret) => this.companySelected(siret)
    })
  }

  disconnect() {
    if (this.tomSelect) {
      this.tomSelect.destroy()
    }
  }

  async loadOptions(query, callback) {
    if (!query.length) return callback()

    try {
      const response = await fetch(`/api/companies/search?q=${encodeURIComponent(query)}`)
      const data = await response.json()
      
      const options = data.map(company => ({
        ...company,
        display_name: `${company.company_name} (${company.siret})`
      }))
      
      callback(options)
    } catch (error) {
      console.error("Error loading companies:", error)
      callback()
    }
  }

  companySelected(siret) {
    const selectedOption = this.tomSelect.options[siret]
    if (selectedOption) {
      this.companyNameTarget.value = selectedOption.company_name
      this.siretTarget.value = selectedOption.siret
    }
  }
}
