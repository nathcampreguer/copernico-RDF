# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Contact do
  let(:contact) { FactoryGirl.create(:contact)}

  specify { expect(contact).to respond_to(:name) }
  specify { expect(contact).to respond_to(:role) }
  specify { expect(contact).to respond_to(:organization) }
  specify { expect(contact).to respond_to(:address) }
  specify { expect(contact).to respond_to(:city) }
  specify { expect(contact).to respond_to(:country) }
  specify { expect(contact).to respond_to(:zipcode) }
  specify { expect(contact).to respond_to(:phone) }
  specify { expect(contact).to respond_to(:email) }
end
