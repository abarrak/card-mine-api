json.extract! template, :id, :name, :image, :description, :created_at, :updated_at
json.url "#{@base_url}/#{template.image}"
