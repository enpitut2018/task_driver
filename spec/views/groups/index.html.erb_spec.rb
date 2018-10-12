require 'rails_helper'

RSpec.describe "groups/index", type: :view do
  before(:each) do
    assign(:groups, [
      Group.create!(
        :parent_id => 2,
        :name => "Name",
        :user_id => 3,
        :importance => 4
      ),
      Group.create!(
        :parent_id => 2,
        :name => "Name",
        :user_id => 3,
        :importance => 4
      )
    ])
  end

  it "renders a list of groups" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
