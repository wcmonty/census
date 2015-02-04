require 'rails_helper'

RSpec.describe 'people/index', type: :view do
  before(:each) do
    assign(:people, [
      Person.create!(
        gender: 'Gender',
        height: 1,
        weight: 2
      ),
      Person.create!(
        gender: 'Gender',
        height: 1,
        weight: 2
      )
    ])
  end

  it 'renders a list of people' do
    render
    assert_select 'tr>td', text: 'Gender'.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
