class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if params['q'].nil?
      @tasks = Task.where(user_id: current_user.id)
    end
    @q = Task.where(user_id: current_user.id).ransack(params[:q])
    @results = @q.result(distinct: true)

  end
  # GET /tasks/1
  # GET /tasks/1.json
  def show
    #tweet("テスト")
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end 

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    #task_data = {}
    #task_data.merge!(task_params)
    #task_data['user_id'] = current_user.id
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def tweet(text)
    twitter_client.update(text)
  end

  private
  def twitter_client
    @oauth = Oauth.where(user_id: current_user.id)[0]
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = @oauth.access_token
      config.access_token_secret = @oauth.access_token_secret
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
   end
  def status_change
    @task = Task.find(params[:id])
    if @task.id < 3
      @task.status += 1
    end
    @task.save
    redirect_to :action => "index"
  end
  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      #uid = current_user.id
      deadline = Date.new(params['task']["deadline(1i)"].to_i, params['task']["deadline(2i)"].to_i, params['task']["deadline(3i)"].to_i)
      #deadline = params['task']["deadline(1i)"]
      diff = (deadline - Date.today).to_i
      urgency = 5

      if diff == 0
        urgency = 5
      elsif diff < 3
        urgency = 4
      elsif diff >= 3 && diff <= 31
        urgency = 3
      elsif diff > 31 && diff <= 62
        urgency = 2
      elsif diff > 62
        urgency = 1
      end

      priority = params['task']['importance'].to_i * urgency
      
      params['task']['user_id'] = current_user.id
      params['task']['urgency'] = urgency
      params['task']['priority'] = priority

      params.require(:task).permit(:name, :deadline, :importance, :note, :status, :start_time, :finish_time, :user_id, :urgency, :priority)
    end
end
