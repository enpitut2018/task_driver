class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new()
  end

  # GET /groups/1/edit
  def edit
  end

  # Fork method
  def fork
    def search(parent_id, new_parent_id)
      while true do
        @groups = Group.where(parent_id: parent_id)
        if @groups.empty?
          break
        else
          @groups.each do |group|
            group_attribute = group.attributes
            group_attribute.delete('id')
            group_attribute.delete('created_at')
            group_attribute.delete('updated_at')
            @group = Group.new(group_attribute.merge({:user_id => current_user.id, :parent_id => new_parent_id}))
            @group.save
            @tasks = Task.where(group_id: group.id)
            
            @tasks.each do |task|
              task_attribute = task.attributes

              task_attribute.delete('id')
              task_attribute.delete('created_at')
              task_attribute.delete('updated_at')
              @task = Task.new(task_attribute.merge({:user_id => current_user.id, :group_id => new_parent_id}))
              @task.save
            end

            search(group.id, @group.id)
          end
          break
        end
      end
      #return new_parent_id
    end

    # respond_to do |format|
    #   format.html { redirect_to groups_url, notice: attribute }
    #   format.json { head :no_content }
    # end

    @group = Group.where(id: params[:id])
    attribute = @group[0].attributes
    attribute.delete('id')

    @parent_group = Group.new(attribute.merge({:user_id => current_user.id}))
    @parent_group.save
    search(params[:id], @parent_group.id)

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'でけた' }
      format.json { head :no_content }
    end
    # まず、親のグループを参照
    # 親グループを作成
    # 子のグループがあるかどうか確認
    # 子のグループがある場合は、そのグループを作成
    # その子のグループがあるかどうか、確認
    #　以下繰り返し

  end

  # POST /groups
  # POST /groups.json
  def create
  
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params['group']['user_id'] = current_user.id
      params.require(:group).permit(:parent_id, :name, :user_id, :importance, :deadline, :visible)
    end
end
