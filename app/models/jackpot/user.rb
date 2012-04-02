module Jackpot

  def self.table_name_prefix
    'jackpot_'
  end

  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, 
           :registerable,
           :recoverable, 
           :rememberable, 
           :trackable, 
           :validatable, 
           :token_authenticatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, 
                    :password, 
                    :password_confirmation, 
                    :authentication_token, 
                    :remember_me
  end

end 
