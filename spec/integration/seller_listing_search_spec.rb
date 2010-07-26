require "spec_helper"

module Sucker
  describe "Seller Listing Search" do
    before do
      @worker = Sucker.new(
        :locale => "us",
        :key    => amazon["key"],
        :secret => amazon["secret"])

      # @worker.curl { |curl| curl.verbose = true }

      @worker << {
        "Operation"   => "SellerListingSearch",
        "SellerId"    => "A31N271NVIORU3" }
      @listings = @worker.get["SellerListingSearchResponse"]["SellerListings"]
    end

    it "returns page count" do
      @listings["TotalPages"].to_i.should be > 0
    end

    it "returns listings" do
      @listings["SellerListing"].size.should be > 0
      @listings["SellerListing"].first.has_key?("Price").should be_true
    end
  end
end