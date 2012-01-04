def next_year 
  Time.now.year + 1 
end


def credit_card(number = '4242424242424242', params = {})
  ActiveMerchant::Billing::CreditCard.new(credit_card_hash)
end 

def credit_card_hash(number = '4242424242424242', params={})
  default_opts = { :number     => number,
                   :month      => '1',
                   :year       => Time.now.year + 1,
                   :first_name => 'John',
                   :last_name  => 'Doe',
                   :verification_value  => '123 ' }.reverse_merge(params)
end 
