require 'rails_helper'

RSpec.describe "groups/edit", type: :view do
  before(:each) do
    @group = assign(:group, Group.create!(
      :parent_id => 1,
      :name => "MyString",
      :user_id => 1,
      :importance => 1
    ))
  end

  it "renders the edit group form" do
    render

    assert_select "form[action=?][method=?]", group_path(@group), "post" do

      assert_select "input[name=?]", "group[parent_id]"

      assert_select "input[name=?]", "group[name]"

      assert_select "input[name=?]", "group[user_id]"

      assert_select "input[name=?]", "group[importance]"
    end
  end
end
