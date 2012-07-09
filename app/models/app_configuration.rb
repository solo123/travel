# This is the primary location for defining spree preferences
#
# The expectation is that this is created once and stored in
# the spree environment
#
# setters:
# a.color = :blue
# a[:color] = :blue
# a.set :color = :blue
# a.preferred_color = :blue
#
# getters:
# a.color
# a[:color]
# a.get :color
# a.preferred_color
#
  class AppConfiguration < Preferences::Configuration
    # Alphabetized to more easily lookup particular preferences
    preference :address_requires_state, :boolean, :default => true # should state/state_name be required
    preference :admin_list_per_page, :integer, :default => 12
    preference :site_name, :string, :default => 'jimmy''s Demo Site'
    preference :max_reservation_days, :integer, :default => 120
    preference :schedule_generated_date, :string, :default => ''
  end

