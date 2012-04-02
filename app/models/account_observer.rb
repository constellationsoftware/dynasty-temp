class AccountObserver < ActiveRecord::Observer
    def before_create(transaction)
        if transaction.transaction_datetime.nil?
            # if we're in the staging or production environments, use the current time, otherwise use the Clock
            if %w( staging production ).include? Rails.env
                transaction.transaction_datetime = DateTime.now
            else
                transaction.transaction_datetime = Clock.first.time
            end
        end
    end
end
