require 'spec_helper'

describe Jackpot::Customer do
  it { should belong_to(:subscription) } 
end
