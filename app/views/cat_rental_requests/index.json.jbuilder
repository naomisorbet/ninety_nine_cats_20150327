json.array!(@cat_rental_requests) do |cat_rental_request|
  json.extract! cat_rental_request, :id, :cat_id, :start_date, :end_date
  json.url cat_rental_request_url(cat_rental_request, format: :json)
end
