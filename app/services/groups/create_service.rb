module Groups
  class CreateService < BaseService
    def initialize(params)
      @params = params.dup
    end

    def execute
      @group = Group.new(@params)
      @group.save
      @group
    end

  end
end
