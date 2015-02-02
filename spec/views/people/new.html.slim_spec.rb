require 'rails_helper'

RSpec.describe "people/new", :type => :view do
  before(:each) do
    assign(:person, Person.new(
      :gender => "MyString",
      :height => 1,
      :weight => 1
    ))
  end

  it "renders new person form" do
    render

    assert_select "form[action=?][method=?]", people_path, "post" do

      assert_select "input#person_gender[name=?]", "person[gender]"

      assert_select "input#person_height[name=?]", "person[height]"

      assert_select "input#person_weight[name=?]", "person[weight]"
    end
  end
end
