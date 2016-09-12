class AdminAuctionStatusPresenter::Base
  attr_reader :auction

  def initialize(auction:, user: nil)
    @auction = auction
    @user = user
  end

  def action_partial
    'components/null'
  end

  def alert_css_class
    'usa-alert-info'
  end

  protected

  def winner
    WinningBid.new(auction).find.bidder
  end
end
