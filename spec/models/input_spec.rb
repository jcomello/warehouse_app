require 'spec_helper'

describe Input do
  describe ".search" do

    let!(:input)          { FactoryGirl.create(:input, created_at: 6.months.ago) }
    let!(:other_input)    { FactoryGirl.create(:input, created_at: 3.months.ago) }
    let!(:one_more_input) { FactoryGirl.create(:input) }

    context "when no parameters was given" do
      it "returns all inputs" do
        Input.search({}).count.should eq 3
      end
    end

    context "when both parameters was given" do
      let(:options) { { search_start: 4.months.ago, search_end: 1.day.from_now } }

      it "returns filtered inputs" do
        Input.search(options).count.should eq 2
      end

      it "returns the right inputs" do
        Input.search(options).should_not include(input)
      end
    end

    context "when only start parameter was given" do
      let(:options) { { search_start: 4.months.ago } }

      it "returns filtered inputs" do
        Input.search(options).count.should eq 2
      end

      it "returns the right inputs" do
        Input.search(options).should_not include(input)
      end
    end

    context "when only end parameter was given" do
      let(:options) { { search_end: 1.month.ago } }

      it "returns filtered inputs" do
        Input.search(options).count.should eq 2
      end

      it "returns the right inputs" do
        Input.search(options).should_not include(one_more_input)
      end
    end
  end
end
