class User < ActiveRecord::Base
    has_many :documents

    def self.create_account(auth)
        User.create provider: auth['provider'],
            uid: auth['uid'],
            username: auth['info']['nickname'],
            avatar: auth['info']['image']
    end
end