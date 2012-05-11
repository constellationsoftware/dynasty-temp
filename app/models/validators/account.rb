class Validators::Account < ActiveModel::Validator
    def validate(transaction)
        # make sure balance agrees with actual object balance
        transaction.receivable.balance === (transaction.receivable_balance + transaction.amount) unless transaction.receivable_balance.nil?
        transaction.payable.balance === (transaction.payable_balance + transaction.amount) unless transaction.payable_balance.nil?
    end
end
