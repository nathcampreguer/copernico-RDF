require 'spec_helper'

describe MetadataRecord do
  let(:record) { FactoryGirl.create(:metadata_record)}

  context 'Information' do
    specify { expect(record).to respond_to(:title) }
    specify { expect(record).to respond_to(:date) }
    specify { expect(record).to respond_to(:status) }
    specify { expect(record).to respond_to(:credits) }
    specify { expect(record).to respond_to(:abstract) }
    specify { expect(record).to respond_to(:keywords) }
  end

  context 'Metadata' do
    specify { expect(record).to respond_to(:uuid) }
    specify { expect(record).to respond_to(:language) }
    specify { expect(record).to respond_to(:character_set) }
    specify { expect(record).to respond_to(:standard_name) }
    specify { expect(record).to respond_to(:standard_version) }
  end

  context 'Quality' do
    specify { expect(record).to respond_to(:scope) }
    specify { expect(record).to respond_to(:statement) }
    specify { expect(record).to respond_to(:maintainance) }
  end

  context 'Contacts' do
    specify { expect(record).to respond_to(:points_of_contact) }
    specify { expect(record).to respond_to(:authors) }
  end
end
