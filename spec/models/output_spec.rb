require 'spec_helper'

describe Output do
  describe ".search" do

    let!(:output)          { FactoryGirl.create(:output, created_at: 6.months.ago) }
    let!(:other_output)    { FactoryGirl.create(:output, created_at: 3.months.ago) }
    let!(:one_more_output) { FactoryGirl.create(:output) }

    context "when no parameters was given" do
      it "returns all outputs" do
        Output.search({}).count.should eq 3
      end
    end

    context "when both parameters was given" do
      let(:options) { { search_start: 4.months.ago, search_end: 1.day.from_now } }

      it "returns filtered outputs" do
        Output.search(options).count.should eq 2
      end

      it "returns the right outputs" do
        Output.search(options).should_not include(output)
      end
    end

    context "when only start parameter was given" do
      let(:options) { { search_start: 4.months.ago } }

      it "returns filtered outputs" do
        Output.search(options).count.should eq 2
      end

      it "returns the right outputs" do
        Output.search(options).should_not include(output)
      end
    end

    context "when only end parameter was given" do
      let(:options) { { search_end: 1.month.ago } }

      it "returns filtered outputs" do
        Output.search(options).count.should eq 2
      end

      it "returns the right outputs" do
        Output.search(options).should_not include(one_more_output)
      end
    end
  end
end
