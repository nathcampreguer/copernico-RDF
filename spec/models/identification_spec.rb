require 'spec_helper'

describe Identification do
  let(:identification) { FactoryGirl.create(:identification)}

  specify { expect(identification).to respond_to(:title) }
  specify { expect(identification).to respond_to(:dates) }
  specify { expect(identification).to respond_to(:status) }
  specify { expect(identification).to respond_to(:credits) }
  specify { expect(identification).to respond_to(:abstract) }
  specify { expect(identification).to respond_to(:keywords) }
end
