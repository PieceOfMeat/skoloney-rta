require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "home page" do
    before { visit root_path }

    it { should have_selector('a.brand', :text => 'Advert system') }
    it { should have_selector('a', :text => 'Home Page')}
  end

end