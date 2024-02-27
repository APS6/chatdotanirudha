# app/channels/application_cable/connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      if current_user
        current_user.update(online: true) 
      end

    def disconnect
      current_user.update(online: false) if current_user
    end

    end

    private
    def find_verified_user
      env['warden'].user
    end
  end
end
