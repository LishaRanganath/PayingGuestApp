module OwnersManager
    class OwnerCreator
        attr_reader :errors
        def initialize(params, owner_class = Owner, admin_id)
            @params = params
            @owner_class = owner_class
            @admin_id = admin_id
        end
        
        def create
            owner = @owner_class.new(@params.merge(@admin_id))
            debugger
            if owner.save
                owner.user.update(role: 'owner')
                return true
            else
                @errors=owner.errors.full_messages
                return @errors
            end
        end
    end
end