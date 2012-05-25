class LoggedInConstraint < Struct.new(:value)
    def matches?(request)
        request.cookies.has_key? 'remember_user_token'
    end
end
