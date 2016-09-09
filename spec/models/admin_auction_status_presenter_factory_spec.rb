require 'rails_helper'

describe AdminAuctionStatusPresenterFactory do
  context 'when the auction approval is not requested' do
    it 'should return a C2StatusPresenter::NotRequested' do
      auction = create(:auction, c2_status: :not_requested)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(C2StatusPresenter::NotRequested)
    end
  end

  context "when the auction has been published but hasn't started yet" do
    it 'should return a BidStatusPresenter::Future::Admin' do
      auction = create(:auction, :future, :published)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(BidStatusPresenter::Future::Admin)
    end
  end

  context "when the auction is over but a work in progress" do
    it 'should return a BidStatusPresenter::Over::Admin::WorkInProgress' do
      auction = create(:auction, :closed, :with_bids, :delivery_url)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(BidStatusPresenter::Over::Admin::WorkInProgress)
    end
  end

  context 'when the auction has been accepted' do
    it 'should return a BidStatusPresenter::Over::Admin::Accepted' do
      auction = create(:auction, :closed, :with_bids, :delivery_url, :accepted)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(BidStatusPresenter::Over::Admin::Accepted)
    end
  end

  context 'when the auction has been rejected' do
    it 'should return a BidStatusPresenter::Over::Admin::Rejected' do
      auction = create(:auction, :closed, :with_bids, :delivery_url, :rejected)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(BidStatusPresenter::Over::Admin::Rejected)
    end
  end

  context 'when the auction approval request is sent' do
    it 'should return a C2StatusPresenter::Sent' do
      auction = create(:auction, c2_status: :sent)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(C2StatusPresenter::Sent)
    end
  end

  context 'when the auction approval request is pending' do
    it 'should return a C2StatusPresenter::PendingApproval' do
      auction = create(:auction, c2_status: :pending_approval)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(C2StatusPresenter::PendingApproval)
    end
  end

  context 'when auction is approved' do
    it 'should return a C2StatusPresenter::Approved' do
      auction = create(:auction, c2_status: :approved)

      expect(AdminAuctionStatusPresenterFactory.new(auction: auction).create)
        .to be_a(C2StatusPresenter::Approved)
    end
  end
end
