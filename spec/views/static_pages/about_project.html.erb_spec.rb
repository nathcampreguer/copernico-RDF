# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'about_project' do

  before { visit about_project_path }

  it { expect(page).to have_title('Copernico') }

  it { expect(page).to have_link('Sobre Metadados') }

  it { expect(page).to have_link('Sobre o Projeto') }

  it { expect(page).to have_content('Logo') }

end
