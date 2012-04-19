# == Schema Information
#
# Table name: weather_conditions
#
#  id                :integer(4)      not null, primary key
#  event_id          :integer(4)      not null
#  temperature       :string(100)
#  temperature_units :string(40)
#  humidity          :string(100)
#  clouds            :string(100)
#  wind_direction    :string(100)
#  wind_velocity     :string(100)
#  weather_code      :string(100)
#

class WeatherCondition < ActiveRecord::Base
    belongs_to :event
end
