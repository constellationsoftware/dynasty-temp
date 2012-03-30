class Account extends Spine.Model
    @configure 'Account', 'balance', 'cap', 'payroll', 'payroll_total', 'cap_difference', 'deficit'
    @extend Spine.Model.Ajax

    @url: '/team/balance'

window.Account = Account
