json.array!(@hydramata_groups) do |hydramata_group|
  json.extract! hydramata_group, :id, :name
  json.url hydramata_group_url(hydramata_group, format: :json)
end
