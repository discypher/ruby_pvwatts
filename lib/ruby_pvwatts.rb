require 'rubygems'
require 'httparty'
require 'json'

# Creates the wrapper object for querying NREL PVWatts. Uses the JSON
# API provided by NREL. More information is available at
# http://developer.nrel.gov/docs/solar/pvwatts-v5/
#
# @params [String] api_key Obtained from http://developer.nrel.gov/signup
#
# @author Shad Self
#
class RubyPvWatts
  include HTTParty

  base_uri 'https://developer.nrel.gov'
  format :json

  # == Required Parameters
  #
  # These are the minimum fields required to use the API.
  # Support for file_id has not been implemented. Additionally, the callback
  # option is not supported.
  #
  # [:+system_capacity+:] Nameplate capacity (kW) Range: 0.05 to 500000
  # [:+module_type+:]  Module Type. 0=standard 1=premium 2=thin film
  # [:+losses+:] System losses (percent). Range -5 to 99
  # [:+array_type+:] Array Type
  #   0 = Fixed - Open Rack
  #   1 = Fixed - Roof Mounted
  #   2 = 1-Axis
  #   3 = 1-Axis Backtracking
  #   4 = 2-Axis
  # [:+tilt+:] Tilt angle (degrees). range: 0 to 90
  # [:+azimuth+:] Azimuth angle (degrees) Range: 0 to 359
  #
  # == Conditional Params
  #
  # [:+address+:] The address to use. (lat/lon returned by Google's geocoding
  #   service). Required if lat/lon is not specified
  # [:+lat+:] The latitude for the location in use. Required if address is not
  #   specified.
  # [:+lon+:] The longitude for the location in use. Required if address is not
  #   specified.
  #
  # == Optional Parameters
  #
  # [:+dataset+:] The climate dataset to use.
  #   tmy2 = TMY2 station data (see http://rredc.nrel.gov/solar/old_data/nsrdb/1961-1990/tmy2/State.html)
  #   tmy3 = TMY3 station data (see http://rredc.nrel.gov/solar/old_data/nsrdb/1991-2005/tmy3/by_USAFN.html)
  #   intl = International station data
  # [:+radius+:] The search radius to use when searching for the closest
  #   climate data station (miles). Pass in radius=0 to use the closest
  #   station regardless of the distance.
  # [:+timeframe+:] Granularity of the output response
  # [:+dc_ac_ratio+:] DC to AC ratio
  # [:+gcr+:] Ground coverage ratio
  # [:+inv_eff+:] Inverter efficiency at rated power.
  #
  def initialize(api_key, opts)
    options = { query: { api_key: api_key }.merge(opts) }
    @response = self.class.get('/api/pvwatts/v5.json', options)
  end

  def poa_monthly
    @response['outputs']['poa_monthly']
  end

  def dc_monthly
    @response['outputs']['dc_monthly']
  end

  def ac_monthly
    @response['outputs']['ac_monthly']
  end

  def solrad_monthly
    @response['outputs']['solrad_monthly']
  end

  def solrad_annual
    @response['outputs']['solrad_annual']
  end

  def ac
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['ac']
  end

  def poa
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['poa']
  end

  def dn
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['dn']
  end

  def dc
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['dc']
  end

  def df
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['df']
  end

  def tamb
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['tamb']
  end

  def tcell
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['tcell']
  end

  def wspd
    return nil unless @response['inputs']['timeframe'] == 'hourly'
    @response['outputs']['wspd']
  end

  alias_method :hourly_ac_output, :ac
  alias_method :hourly_plane_of_array_irradiance, :poa
  alias_method :hourly_beam_normal_irradiance, :dn
  alias_method :hourly_diffuse_irradiance, :dc
  alias_method :hourly_ambient_temperature, :tamb
  alias_method :hourly_module_temperature, :tcell
  alias_method :hourly_windspeed, :wspd
end
