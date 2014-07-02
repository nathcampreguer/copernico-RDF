require 'spec_helper'

describe 'about_metadata' do

  before { visit about_metadata_path }

  it { expect(page).to have_title('Copernico') }

  it { expect(page).to have_link('Sobre Metadados') }

  it { expect(page).to have_link('Sobre o Projeto') }

  it { expect(page).to have_content('IDE/USP') }

end
