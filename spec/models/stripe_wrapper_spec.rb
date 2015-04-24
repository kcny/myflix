require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "charges successfully", :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 4,
            :exp_year => 2020,
            :cvc => "314"
          },
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "valid charge"
          )

        expect(response).to be_successful
      
      end

      it "makes a card declined charge", :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 4,
            :exp_year => 2019,
            :cvc => "314"
          }
        ).id 

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "an invalid charge"
          )

          expect(response).not_to be_successful
       end
      it "returns the error message for declined charges", :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 4,
            :exp_year => 2019,
            :cvc => "314"
          }
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "an invalid charge"
          )

          expect(response.error_message).not_to eq("Your card was declined")
          
      end 
    end
  end
end
