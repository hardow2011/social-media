module CommunitySetting
  extend ActiveSupport::Concern

  included do
    def set_community_by_handle(handle)
      @community =  Community.get_by_handle(handle)
    end
  end
end
