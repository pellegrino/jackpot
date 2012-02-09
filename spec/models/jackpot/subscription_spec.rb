require 'spec_helper'

describe Jackpot::Subscription do
  it { should have_many(:customers)       } 
  it { should validate_presence_of :name  }
  it { should have_many(:payments)        }
end
