module Owner
    class OwnerCreator
        attr_reader :errors
        def initialize(params, owner_class = Owner, admin_id)
            @params = params
            @owner_class = restaurant_class
        end
        
        def create
            owner = @owner_class.new(@params)
            if owner.save
                return true
            else
                @errors=owner.errors.full_messages
                return @errors
            end
        end
    end
end