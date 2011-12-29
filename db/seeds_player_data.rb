def get_condition_string(value)
  return "SUBSTRING_INDEX(SUBSTRING_INDEX(abbreviation, ',', 1), '/', 1) LIKE '#{value}'"
end

positions_file = File.join(Rails.root, 'lib', 'assets', 'positions.yml')
valid_positions = YAML::load(File.open(positions_file))

valid_positions.each do |abbr, data|
  group_name = (data.kind_of? String) ? data : data['name']
  aliases = (data.kind_of? Hash) ? data['aliases'] : []
  position_group = PositionGroup.find_or_create_by_name(group_name) { |u| u.abbreviation = abbr }

  # now that we have the position groups records, search for corresponding
  # positions and link them
  conditions = Array.new
  conditions << get_condition_string(abbr)
  conditions << get_condition_string(group_name.parameterize)
  aliases.each do |value|
    conditions << get_condition_string(value.parameterize)
  end
  positions = Position.where(conditions.join(' OR '))

  # make the link
  positions.each do |position|
    position.position_group_id = position_group.id
    position.save
  end
end
