require 'spec_helper'

describe MetadataRecord do
  before (:all) do
    @record = MetadataRecord.new(uuid: '6c4677cd-76b2-40d2-8745-a392ccb616ea',
      title: 'Localities in Victoria',
      abstract: 'This dataset is the definitive set of locality boundaries',
      keywords: ['BOUNDARIES-Administrative', 'LAND-Ownership', 'boundaries'])
  end

  describe 'attributes' do
    context 'uuid not present' do
      before{ @record.uuid = nil }
      it{ expect(@record).not_to be_valid }
    end

    context 'title not present' do
      before{ @record.title = nil }
      it{ expect(@record).not_to be_valid }
    end

    context 'abstract not present' do
      before{ @record.abstract = nil }
      it{ expect(@record).not_to be_valid }
    end

    context 'keywords not present' do
      before{ @record.keywords = nil }
      it{ expect(@record).not_to be_valid }
    end
  end
end
