module TasksHelper
  def symbol(task)
    raise 'TasksHelper symbol method - variable "task" is not a task' unless task.is_a? Task

    case task.current_status
    when :pending then OpenStruct.new(icon: '»', color: :primary)
    when :done    then OpenStruct.new(icon: '✓', color: :success)
    when :expired then OpenStruct.new(icon: '⊗', color: :danger )
    end
  end
end
