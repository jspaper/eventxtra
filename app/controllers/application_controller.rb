class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    
  before_action :mobile_view_path
    
  layout :which_layout
  
  private
  
    def mobile_device?
      request.user_agent =~ /Mobile|webOS|Android/ and not(request.user_agent =~ /Googlebot/i)
    end
    helper_method :mobile_device?

    def mobile_view_path
      if mobile_device?
        prepend_view_path "app/views/mobile"
      end
    end

    def which_layout
      mobile_device? ? 'mobile' : 'application'
    end
end
