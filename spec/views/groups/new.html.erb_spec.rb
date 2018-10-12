require 'rails_helper'

RSpec.describe "groups/new", type: :view do
  before(:each) do
    assign(:group, Group.new(
      :parent_id => 1,
      :name => "MyString",
      :user_id => 1,
      :importance => 1
    ))
  end

  it "renders new group form" do
    render

    assert_select "form[action=?][method=?]", groups_path, "post" do

      assert_select "input[name=?]", "group[parent_id]"

      assert_select "input[name=?]", "group[name]"

      assert_select "input[name=?]", "group[user_id]"

      assert_select "input[name=?]", "group[importance]"
    end
  end
end
