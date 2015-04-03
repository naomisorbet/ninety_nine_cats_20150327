json.array!(@cats) do |cat|
  json.extract! cat, :id, :birth_date, :color, :name, :sex, :description
  json.url cat_url(cat, format: :json)
end
