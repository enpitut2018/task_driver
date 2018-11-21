class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  include Pixela
  include GroupUtil

  # GET /tasks
  # GET /tasks.json
  def index

    if current_user.sign_in_count.zero?
      group = Group.create(
        name: "general",
        user_id: current_user.id
      )
      
      group.save
    end

    if params['q'].nil?
      @tasks = Task.where(user_id: current_user.id).order('priority DESC')
    end
    @q = Task.where(user_id: current_user.id).order('priority DESC').ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    #5分タイマーを作動させるフラグ
    if (params[:timer] == '1')
      @timer = 1;
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end 

  # GET /tasks/1/edit
  def edit
  end

  # GET /tasks/done
  def done
    @tasks = Task.where(user_id: current_user.id).order('finish_time DESC')
    @graph = get_graph
  end

  # GET /tasks/importance
  def importance
    if params[:limit]
      limit = params[:limit].to_i
    else
      limit = 1
    end
    importance = Task.where(user_id: current_user.id).order('importance DESC, urgency DESC').limit(limit)
    
    render :json => importance
    # redirect_to controller: 'tasks', action: 'show', id: importance.id, timer: 1
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

  def status_change
    @task = Task.find(params[:id])
    if @task.status == 1
      @task.start_time = Time.zone.now
      @task.status += 1

      if Oauth.where(user_id: current_user.id)[0]
        # tweetText = "今から頑張って、タスクに取り組みます！\n応援してください!\n完了報告をお楽しみに！#Folivora"
        # tweet(tweetText)
      end

    elsif @task.status == 2
      @task.finish_time = Time.zone.now
      @task.status += 1
      save_commitment(Time.gm(2018, 8, 17))

      if Oauth.where(user_id: current_user.id)[0]
        # tweetText = "タスクおわりました！\n応援ありがとうございました!\n#Folivora"
        # tweet(tweetText)
      end

    end

    @task.save
    #redirect_to :action => "index"
    redirect_to controller: 'tasks', action: 'show', id: @task.id
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
  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  helper_method :get_ancestor_groups

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

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    deadline = Date.new(params['task']["deadline(1i)"].to_i, params['task']["deadline(2i)"].to_i, params['task']["deadline(3i)"].to_i)
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

    if params['task'].key?('id')
      params['task']['user_id'] = Task.find(params['task']['id']).user_id
    else
      params['task']['user_id'] = current_user.id
    end

    params['task']['urgency'] = urgency
    params['task']['priority'] = priority

    params.require(:task).permit(:name, :deadline, :importance, :note, :status, :start_time, :finish_time, :user_id, :urgency, :priority, :group_id)
  end
end
