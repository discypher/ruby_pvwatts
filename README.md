# ruby_pvwatts

Provides a wrapper for NREL PVWatts v5 API. Currently only supports JSON format.
Usage:
You need to pass in an API Key, which is obtained from the NREL.
Additionally, you'll need to include a hash of at least the required parameters.
See http://developer.nrel.gov/docs/solar/pvwatts-v5/ for more information.

Usage:

    require 'ruby_pvwatts'

    result = RubyPvWatts.new(
      api_key: 'YOUR_API_KEY',
      system_capacity: 5,
      module_type: 1,
      losses: 14,
      array_type: 1,
      tilt: 22,
      azimuth: 143,
      address: '123 Fake Street Anytown CO, 12345',
      dataset: 'tmy3',
      radius: 0
    )

    result.solrad_annual # => 5.63514852538037

[Licensed under the MIT license](http://www.opensource.org/licenses/mit-license.php)