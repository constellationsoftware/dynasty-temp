ActiveAdmin.register Account do

    index do
        column :id
        column "From: ", :payable
        column :payable_type
        column "To: ", :receivable
        column :receivable_type
        column "Event Type", :eventable_type

        column "Amount", :amount_cents
    end
end
