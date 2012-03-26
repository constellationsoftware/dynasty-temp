require 'test_helper'
require 'fixtures/sample_reserve'

class ReserveTest < ActiveSupport::TestCase
    test 'sample reserve is a singleton' do
        reserve1 = SampleReserve.instance
        reserve2 = SampleReserve.instance
        reserve1 === reserve2
    end

    test 'sample reserve has an "id" attribute' do
        reserve = SampleReserve.instance
        reserve.id = 0
        assert_equal 0, reserve.id
    end
end
