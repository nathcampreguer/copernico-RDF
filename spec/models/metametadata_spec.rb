require 'spec_helper'

describe Metametadata do
  let(:metametadata) { FactoryGirl.create(:metametadata)}

  specify { expect(metametadata).to respond_to(:uuid) }
  specify { expect(metametadata).to respond_to(:languages) }
  specify { expect(metametadata).to respond_to(:character_sets) }
  specify { expect(metametadata).to respond_to(:standard_name) }
  specify { expect(metametadata).to respond_to(:standard_version) }
end

