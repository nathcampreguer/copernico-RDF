require 'spec_helper'

describe Quality do
  let(:quality) { FactoryGirl.create(:quality)}

  specify { expect(quality).to respond_to(:scope) }
  specify { expect(quality).to respond_to(:statement) }
  specify { expect(quality).to respond_to(:maintainance) }
end
