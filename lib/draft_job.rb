class DraftJob
    @queue = :drafts

    class << self
        def perform(id)
            draft = Draft.find(id)
        end
    end

    extend Resque::Plugins::AccessWorkerFromJob
end
