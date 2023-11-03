gateway = Braintree::Gateway.new(
	:environment=>:sandbox,
	:merchant_id=>Rails.application.credentials.dig(:braintree, :merchant_id,
	:public_key=>Rails.application.credentials.dig(:braintree, :public_key,
	:private_key=>Rails.application.credentials.dig(:braintree, :private_key
)