class Forgery
    module Extensions
        class Array
            def unique
                @cache = Array.new if @cache.nil?
                return nil if @cache.length === self.length # all values have been "used up"

                value = @cache.empty? ? random : (self - @cache).sample
                @cache << value
                Forgery::Extend(value)
            end
        end
    end
end
