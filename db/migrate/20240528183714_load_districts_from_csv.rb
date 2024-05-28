require 'csv'

class LoadDistrictsFromCsv < ActiveRecord::Migration[7.1]
  def up
    csv_text = File.read(Rails.root.join('db', 'data', 'listado_comunas.csv'))
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      District.create!(name: row['name'])
    end
  end

  def down
    District.delete_all
  end
end