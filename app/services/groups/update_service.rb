module Groups
  class UpdateService < BaseService
    def initialize(group, params)
      @group = group
      @params = params.dup
    end

    def execute
      @group.update(params)
    end

  end
end
