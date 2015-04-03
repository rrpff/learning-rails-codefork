class User < ActiveRecord::Base

    def self.create_account(auth)
        User.create provider: auth['provider'],
            uid: auth['uid'],
            username: auth['info']['nickname'],
            avatar: auth['info']['image']
    end

end