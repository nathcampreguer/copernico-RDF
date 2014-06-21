require 'spec_helper'

describe MetadataRecord do
  let(:record) { FactoryGirl.create(:metadata_record)}
  let(:identification) { FactoryGirl.create(:identification)}
  let(:metametadata) { FactoryGirl.create(:metametadata)}
  let(:quality) { FactoryGirl.create(:quality)}

  context 'Information' do
    specify { expect(record).to respond_to(:identification) }
  end

  context 'Metadata' do
    specify { expect(record).to respond_to(:metametadata) }
  end

  context 'Quality' do
    specify { expect(record).to respond_to(:quality) }
  end

  context 'Contacts' do
    specify { expect(record).to respond_to(:points_of_contact) }
    specify { expect(record).to respond_to(:authors) }
  end
end
