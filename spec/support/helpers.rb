def next_year 
  Time.now.year + 1 
end

def credit_card(number = '4242424242424242', params = {})
  @credit_card ||= ActiveMerchant::Billing::CreditCard.new credit_card_hash(number, params)
end 

def credit_card_hash(number = '4242424242424242', params={})
  default_opts = { "number"              => number,
                   "month"               => 1,
                   "year"                => next_year,
                   "first_name"          => 'John',
                   "last_name"           => 'Doe',
                   "verification_value"  => 123 }.reverse_merge(params)
end 
