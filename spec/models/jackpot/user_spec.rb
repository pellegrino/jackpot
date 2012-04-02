require 'spec_helper'

describe Jackpot::User do
  it { should allow_mass_assignment_of :authentication_token } 
end 
