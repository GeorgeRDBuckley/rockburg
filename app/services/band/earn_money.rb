class Band::EarnMoney < ApplicationService
  expects do
    required(:band).filled
    required(:amount).filled
  end

  delegate :amount, :band, to: :context

  before do
    band = Band.ensure(band)
    context.fail!(message: 'Amount must be positive') unless amount.positive?
  end

  def call
    Manager::EarnMoney.(manager: band.manager, amount: amount, band: band)
  end
end
