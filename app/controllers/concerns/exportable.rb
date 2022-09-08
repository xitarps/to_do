require 'csv'

module Exportable
  extend ActiveSupport::Concern

  def export_csv
    headers = ['ID', 'Descrição', 'Finalizada', 'Id da Tarefa pai', 'Criada em', 'Atualizada em']

    csv = CSV.generate(write_headers: true, headers: headers) do |row|
      Task.all.each do |task|
        row << [
          task.id,
          task.description,
          task.done? ? 'Sim' : 'Não',
          task.parent_id,
          I18n.l(task.created_at),
          I18n.l(task.updated_at)
        ]
      end
    end

    filename = I18n.l(DateTime.current, format: :long).gsub(/[ ,:]/) { '_' }
    send_data csv, type: 'text/csv; charset=utf-8; header=present',
                   disposition: "attachment; filename=#{ filename }.csv"
  end
end
