class ProjectManagerPayout
  def initialize(project_manager, amount)
    @project_manager = project_manager
    @amount = amount
  end

  def process
    return unless @project_manager.stripe_account_id

    begin
      transfer = create_transfer
      record_payout(transfer)
      
      OpenStruct.new(success?: true, transfer: transfer)
    rescue Stripe::StripeError => e
      OpenStruct.new(success?: false, error: e.message)
    end
  end

  private

  def create_transfer
    Stripe::Transfer.create({
      amount: @amount.cents,
      currency: 'eur',
      destination: @project_manager.stripe_account_id,
      description: "Payout for project manager #{@project_manager.id}"
    })
  end

  def record_payout(transfer)
    Payout.create!(
      user: @project_manager,
      amount_cents: @amount.cents,
      stripe_transfer_id: transfer.id,
      status: :completed
    )
  end
end
