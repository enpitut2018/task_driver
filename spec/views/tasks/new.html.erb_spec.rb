require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :name => "MyString",
      :importance => 1,
      :note => "MyText",
      :status => 1
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[name]"

      assert_select "input[name=?]", "task[importance]"

      assert_select "textarea[name=?]", "task[note]"

      assert_select "input[name=?]", "task[status]"
    end
  end
end
