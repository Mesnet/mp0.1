class TasksController < ApplicationController
  before_action :set_task, except: [:create, :index]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
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
    respond_to do |format|
      format.js {render 'tasks/js/update'}
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
