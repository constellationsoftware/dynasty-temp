class DraftObserver < ActiveRecord::Observer
    def after_create(model)
        model.create_pick_records

        ## This restarts the worker process
        #This is not a well documented feature, for more info start here:
        # http://groups.google.com/group/heroku/browse_thread/thread/bcdcf4e99bd35108
        #and also http://rubydoc.info/github/heroku/heroku
        Heroku::Client.new('ben@frontofficemedia.com', 'fom556').ps_restart('dynastyowner', :ps => 'worker.1')

    end
end



