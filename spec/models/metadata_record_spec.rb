require 'spec_helper'

describe MetadataRecord do
  let(:record) { FactoryGirl.create(:metadata_record)}

  describe 'attributes' do

    context 'Identification' do

      context 'title not present' do
        before{ record.title = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'date not present' do
        before{ record.date = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'abstract not present' do
        before{ record.abstract = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'status not present' do
        before{ record.status = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'credits not present' do
        before{ record.credits = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'keywords not present' do
        before{ record.keywords = nil }
        it{ expect(record).not_to be_valid }
      end
    end

    context 'Point of contact' do
      context 'point_contact_name not present' do
        before{ record.point_contact_name = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_role not present' do
        before{ record.point_contact_role = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_organization not present' do
        before{ record.point_contact_organization = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_address not present' do
        before{ record.point_contact_address = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_city not present' do
        before{ record.point_contact_city = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_state not present' do
        before{ record.point_contact_state = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_country not present' do
        before{ record.point_contact_country = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_zipcode not present' do
        before{ record.point_contact_zipcode = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_phone not present' do
        before{ record.point_contact_phone = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'point_contact_email not present' do
        before{ record.point_contact_email = nil }
        it{ expect(record).not_to be_valid }
      end
    end

    context 'Quality' do
      context 'hierarchy_level not present' do
        before{ record.hierarchy_level = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'declaration not present' do
        before{ record.declaration = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'maintainance not present' do
        before{ record.maintainance = nil }
        it{ expect(record).not_to be_valid }
      end
    end

    context 'Metadata' do
      context 'uuid not present' do
        before{ record.uuid = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'language not present' do
        before{ record.language = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'character_set not present' do
        before{ record.character_set = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'standart_name not present' do
        before{ record.standart_name = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'standart_version not present' do
        before{ record.standart_version = nil }
        it{ expect(record).not_to be_valid }
      end
    end

    context 'Metadata author' do
      context 'author_name not present' do
        before{ record.author_name = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_organization not present' do
        before{ record.author_organization = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_role not present' do
        before{ record.author_role = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_address not present' do
        before{ record.author_address = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_city not present' do
        before{ record.author_city = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_state not present' do
        before{ record.author_state = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_country not present' do
        before{ record.author_country = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_name not present' do
        before{ record.author_name = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_zipcode not present' do
        before{ record.author_zipcode = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_phone not present' do
        before{ record.author_phone = nil }
        it{ expect(record).not_to be_valid }
      end

      context 'author_email not present' do
        before{ record.author_email = nil }
        it{ expect(record).not_to be_valid }
      end
    end
  end
end
