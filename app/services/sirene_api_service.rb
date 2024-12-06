class SireneApiService
  include HTTParty
  base_uri 'https://api.insee.fr/entreprises/sirene/V3'

  def initialize
    @token = ENV['SIRENE_API_TOKEN'] || Rails.application.credentials.dig(:sirene, :token)
    @options = {
      headers: {
        'Authorization' => "Bearer #{@token}",
        'Accept' => 'application/json'
      }
    }
  end

  def search_companies(query)
    response = self.class.get("/siret?q=#{URI.encode_www_form_component(query)}", @options)
    
    if response.success?
      parse_companies(response)
    else
      []
    end
  rescue => e
    Rails.logger.error("SIRENE API error: #{e.message}")
    []
  end

  private

  def parse_companies(response)
    establishments = response.dig('etablissements') || []
    establishments.map do |establishment|
      uniteLegale = establishment.dig('uniteLegale') || {}
      {
        siret: establishment['siret'],
        company_name: uniteLegale['denominationUniteLegale'],
        address: format_address(establishment['adresseEtablissement']),
        naf_code: establishment['activitePrincipaleUniteLegale'],
        company_type: uniteLegale['categorieJuridiqueUniteLegale']
      }
    end
  end

  def format_address(address)
    return '' unless address

    [
      address['numeroVoieEtablissement'],
      address['typeVoieEtablissement'],
      address['libelleVoieEtablissement'],
      address['codePostalEtablissement'],
      address['libelleCommuneEtablissement']
    ].compact.join(' ')
  end
end
