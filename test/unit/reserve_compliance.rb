require 'test_helper'
require 'fixtures/sample_reserve'

class ReserveCompliance < ActiveSupport::TestCase
    include ActiveModel::Lint::Tests

    def setup
        @model = SampleReserve.instance
    end
end
