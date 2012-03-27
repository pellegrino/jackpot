require './lib/jackpot/cron'
require './lib/jackpot/errors'

describe Jackpot::Cron do
  let(:logger) { stub(:info => true) } 

  it "finds every overdue customer and bills their cards" do
    customers = [ mock_customer(true), mock_customer(true) ]
    customer_storage = stub(:overdue => customers) 
    cron = Jackpot::Cron.new(customer_storage, logger)
    cron.run
  end 

  context "when something has failed" do
    it "logs the execption" do
      customers = [ mock_customer(true), failed_customer ]
      customer_storage = stub(:overdue => customers) 
      logger.should_receive(:error)
      cron = Jackpot::Cron.new(customer_storage, logger)
      cron.run
    end 
  end 

end 

def mock_customer(return_value)
  customer = stub(:pay_subscription => return_value)
  customer.should_receive(:pay_subscription).and_return(return_value)
  customer
end 

def failed_customer
  customer = Object.new
  customer.stub(:pay_subscription).and_raise(Jackpot::Error.new)
  customer
end 
