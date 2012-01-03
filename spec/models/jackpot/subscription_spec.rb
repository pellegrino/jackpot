require 'spec_helper'

describe Jackpot::Subscription do
  it { should have_many(:customers) } 
end
