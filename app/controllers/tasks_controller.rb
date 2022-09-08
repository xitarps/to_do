class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update destroy ]

  def index
    @tasks = Task.order(due_date: :asc)
  end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    message = "Tarefa criada com sucesso."
    return redirect_to tasks_path, notice: message if @task.save

    flash.now[:alert] = @task.errors.full_messages.to_sentence
    render :new, status: :unprocessable_entity
  end

  def update
    message = "Tarefa atualizada com sucesso."
    return redirect_to tasks_path, notice: message if @task.update(task_params)

    flash.now[:alert] = @task.errors.full_messages.to_sentence
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @task.destroy

    redirect_to tasks_url, notice: "Tarefa removida com sucesso."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_date, :done, :parent_id)
  end
end
