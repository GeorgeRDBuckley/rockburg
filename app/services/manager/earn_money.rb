class Manager::EarnMoney < ApplicationService
  expects do
    required(:manager).filled
    required(:amount).filled
    optional(:band)
  end

  delegate :manager, :amount, :band, to: :context

  before do
    manager = Manager.ensure(manager)
    band = Band.ensure(band)
    context.fail!(message: 'Amount must be positive') unless amount.positive?
  end

  def call
    manager.transaction do
      manager.financials.create!(amount: amount, band: band)
    end
  end
end
