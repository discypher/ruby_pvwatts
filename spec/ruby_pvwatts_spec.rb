require 'spec_helper'

describe RubyPvWatts do
  describe 'Valid input' do
    before :each do
      stub_request(
        :get,
        'https://developer.nrel.gov/api/pvwatts/v5.json?address=123%20Fake%20Street%20Honolulu,%20HI%2096826&api_key=FAKE_API_KEY&array_type=1&azimuth=143&dataset=tmy3&losses=14&module_type=1&radius=0&system_capacity=5&tilt=22'
      ).with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby' }
      ).to_return(
        status: 200,
        body: {
          'inputs' => {
            'system_capacity' => '5',
            'module_type' => '1',
            'losses' => '10',
            'array_type' => '1',
            'tilt' => '22',
            'azimuth' => '143',
            'address' => '825 Coolidge Street Honolulu, HI 96826'
          },
          'errors' => [],
          'warnings' => [],
          'version' => '1.0.2',
          'ssc_info' => {
            'version' => 34,
            'build' => 'Unix 64 bit GNU/C++ Aug 18 2014 13:38:36'
          },
          'station_info' => {
            'lat' => 21.33333396911621,
            'lon' => -157.9166717529297,
            'elev' => 5.0,
            'tz' => -10.0,
            'location' => '22521',
            'city' => 'HONOLULU',
            'state' => 'HI',
            'solar_resource_file' => '22521.tm2',
            'distance' => 10745
          },
          'outputs' => {
            'ac_monthly'      => [606.8814086914062,
                                  607.4061279296875,
                                  725.9041137695312,
                                  696.5216064453125,
                                  768.7184448242188,
                                  738.2608642578125,
                                  767.6920166015625,
                                  777.3290405273438,
                                  759.6552124023438,
                                  693.6257934570312,
                                  601.835693359375,
                                  594.517333984375],
            'poa_monthly'     => [149.582763671875,
                                  149.54965209960938,
                                  179.41624450683594,
                                  171.45758056640625,
                                  190.11830139160156,
                                  182.50790405273438,
                                  189.84628295898438,
                                  193.2172393798828,
                                  189.14675903320312,
                                  171.23056030273438,
                                  148.53952026367188,
                                  146.6793212890625],
            'solrad_monthly'  => [4.825250625610352,
                                  5.34105920791626,
                                  5.787621021270752,
                                  5.715252876281738,
                                  6.132848262786865,
                                  6.083596706390381,
                                  6.124073505401611,
                                  6.232814311981201,
                                  6.304892063140869,
                                  5.523566246032715,
                                  4.951317310333252,
                                  4.73159122467041],
            'dc_monthly'      => [633.7515258789062,
                                  634.22705078125,
                                  757.9922485351562,
                                  727.2393188476562,
                                  802.2755737304688,
                                  771.1595458984375,
                                  801.5697021484375,
                                  811.2010498046875,
                                  792.720947265625,
                                  724.122314453125,
                                  628.6134643554688,
                                  620.5930786132812],
            'ac_annual'       => 8338.3486328125,
            'solrad_annual'   => 5.6461567878723145
          }
        }.to_json,
        headers: {}
      )

      @ruby_pvwatts = RubyPvWatts.new(api_key: 'FAKE_API_KEY',
                                      system_capacity: 5, module_type: 1,
                                      losses: 14, array_type: 1, tilt: 22,
                                      azimuth: 143,
                                      address: '123 Fake Street Honolulu, HI 96826',
                                      dataset: 'tmy3', radius: 0)
    end

    subject { @ruby_pvwatts }

    it { should respond_to :version }
    it { should respond_to :errors }
    it { should respond_to :warnings }
    it { should respond_to :city }
    it { should respond_to :state }
    it { should respond_to :lat }
    it { should respond_to :long }
    it { should respond_to :elev }
    it { should respond_to :location }
    it { should respond_to :timezone }
    it { should respond_to :solar_resource_file }
    it { should respond_to :distance }
    it { should respond_to :meters_from_station }

    it { should respond_to :poa_monthly }
    it { should respond_to :solrad_monthly }
    it { should respond_to :solrad_annual }
    it { should respond_to :dc_monthly }
    it { should respond_to :ac_monthly }
    it { should respond_to :ac }
    it { should respond_to :poa }
    it { should respond_to :dn }
    it { should respond_to :dc }
    it { should respond_to :df }
    it { should respond_to :tamb }
    it { should respond_to :tcell }
    it { should respond_to :wspd }

    it 'should have the correct value for poa_monthly' do
      expect(@ruby_pvwatts.poa_monthly).to eq(
        [149.582763671875, 149.54965209960938, 179.41624450683594,
         171.45758056640625, 190.11830139160156, 182.50790405273438,
         189.84628295898438, 193.2172393798828, 189.14675903320312,
         171.23056030273438, 148.53952026367188, 146.6793212890625])
    end

    it 'should have the correct value for solrad monthly' do
      expect(@ruby_pvwatts.solrad_monthly).to eq(
        [4.825250625610352, 5.34105920791626, 5.787621021270752,
         5.715252876281738, 6.132848262786865, 6.083596706390381,
         6.124073505401611, 6.232814311981201, 6.304892063140869,
         5.523566246032715, 4.951317310333252, 4.73159122467041])
    end

    it 'should have the correct value for solrad annual' do
      expect(@ruby_pvwatts.solrad_annual).to eq(5.6461567878723145)
    end

    it 'should not report hourly values' do
      expect(@ruby_pvwatts.wspd).to be_nil
    end

    it 'should report the correct version' do
      expect(@ruby_pvwatts.version).to eq('1.0.2')
    end

    it 'should have the right city' do
      expect(@ruby_pvwatts.city).to eq('HONOLULU')
    end
  end

  describe 'Invalid input' do
    it 'should raise an ArgumentError' do
      expect { RubyPvWatts.new({}) }.to raise_error(ArgumentError)
    end
  end
end
