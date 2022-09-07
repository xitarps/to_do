class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update destroy ]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    message = "Task was successfully created."
    return redirect_to task_url(@task), notice: message if @task.save

    render :new, status: :unprocessable_entity
  end

  def update
    message = "Task was successfully updated."
    return redirect_to task_url(@task), notice: message if @task.update(task_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    @task.destroy

    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_date, :done)
  end
end
