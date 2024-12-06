class ProcessStripePayment
  def initialize(meeting)
    @meeting = meeting
    @transaction = meeting.transaction
  end

  def call
    return OpenStruct.new(success?: false, error: 'No transaction found') unless @transaction
    return OpenStruct.new(success?: false, error: 'Payment already processed') if @transaction.paid?

    begin
      payment_intent = create_payment_intent
      @transaction.update(
        stripe_payment_id: payment_intent.id,
        status: :paid
      )

      OpenStruct.new(
        success?: true,
        payment_intent: payment_intent
      )
    rescue Stripe::StripeError => e
      @transaction.update(status: :failed)
      OpenStruct.new(success?: false, error: e.message)
    end
  end

  private

  def create_payment_intent
    Stripe::PaymentIntent.create(
      amount: @transaction.amount_cents,
      currency: 'eur',
      customer: @meeting.industrial.stripe_customer_id,
      metadata: {
        meeting_id: @meeting.id,
        industrial_id: @meeting.industrial_id,
        project_manager_id: @meeting.project_manager_id
      }
    )
  end
end
