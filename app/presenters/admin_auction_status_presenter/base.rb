class AdminAuctionStatusPresenter::Base
  attr_reader :auction

  def initialize(auction:, user: nil, bid_error: nil)
    @auction = auction
    @user = user
    @bid_error = bid_error
  end

  def status
    ''
  end

  def action_partial
    'components/null'
  end

  def alert_css_class
    'usa-alert-info'
  end

  protected

  def winner_url
    Url.new(
      link_text: winner.email,
      path_name: 'admin_user',
      params: { id: winner.id }
    )
  end

  def winner
    WinningBid.new(auction).find.bidder
  end
end