class TasksController < ApplicationController
  before_action :set_task, except: [:create, :index, :sort]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks.activ.order(:position)
    @task = Task.new
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show_info
    respond_to do |format|
      format.js {render 'tasks/js/show_info'}
    end
  end

  def upd_done
    if @task.done_at.present?
      done_at = nil
      done_by = nil
    else
      done_at = Time.zone.now
      done_by = current_user.id
    end
    @task.update(done_at: done_at, done_by: done_by)
    if params[:from_parent]
      # This params is to indicate that we're into the parent show info
      @from_parent = true
    end
    respond_to do |format|
      format.js {render 'tasks/js/update'}
    end
  end

  def upd_description
    @task.update(description: params[:description])
  end

  def sort 
    params[:task].each_with_index do |id, index|
      current_user.tasks.find(id).update(position: index + 1)
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    respond_to do |format|
      if @task.save
        format.js {render 'tasks/js/create'}
      else
        @message = "La tâche n'a pas été sauvegardée"
        format.js {render 'layouts/error'}
      end
    end
  end

  def create_linked
    @new_task = Task.create(user: current_user, parent_id: @task.id, title: params[:title])
    respond_to do |format|
      format.js {render 'tasks/js/create'}
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        @message = "Tâche éditée !"
        format.js {render 'tasks/js/update'}
      else
        format.js {render 'layouts/error'}
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :date, :done_at, :done_by, :parent_id, :activ, :position, :user_id)
    end
end
