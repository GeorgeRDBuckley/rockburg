module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_manager

    def connect
      self.current_manager = find_verified_manager
      logger.add_tags 'ActionCable', current_manager.email
    end

    private

    def find_verified_manager
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
