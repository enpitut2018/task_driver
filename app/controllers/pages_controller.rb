class PagesController < ApplicationController
  def page
    @task = Task.all[0]
  end
end
