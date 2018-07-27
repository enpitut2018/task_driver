require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :name => "MyString",
      :deadline => DateTime.new(2011, 12, 24, 00, 00, 00),
      :importance => 1,
      :note => "MyText",
      :status => 1
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input[name=?]", "task[name]"

      assert_select "input[name=?]", "task[importance]"

      assert_select "textarea[name=?]", "task[note]"

      assert_select "input[name=?]", "task[status]"
    end
  end
end
