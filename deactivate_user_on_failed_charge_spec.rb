require 'spec_helper'

describe "Deactivate User On Failed Charge" do
  let(:event_data) do
    {
      "id" => "evt_15xHvdHHAbUnMwm5fE7EUfuo",
      "created" => 1430401333,
      "livemode" => false,
      "type" => "charge.failed",
      "data" => {
        "object" => {
          "id" => "ch_15xHvdHHAbUnMwm5peHzAbFI",
          "object" => "charge",
          "created" => 1430401333,
          "livemode"  => false,
          "paid" => false,
          "status" => "failed",
          "amount" => 999,
          "currency" => "usd",
          "refunded"  => false,
          "source" => {
            "id" => "card_15xHuqHHAbUnMwm5OCxyQvbK",
            "object" => "card",
            "last4" => "0341",
            "brand" =>"Visa",
            "funding" => "credit",
            "exp_month": 4,
            "exp_year" => 2016,
            "fingerprint": "zHnNEVyiI9soMJRa",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country": nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil,
            "dynamic_last4": nil,
            "metadata" => {},
            "customer" => "cus_69ZARHVy1j4stH"
          },
          "captured": =>false,
          "balance_transaction" => nil,
          "failure_message" => "Your card was declined.",
          "failure_code" => "card_declined",
          "amount_refunded": 0,
          "customer" => "cus_69ZARHVy1j4stH",
          "invoice" => nil,
          "description" => "cheese",
          "dispute" => nil,
          "metadata" => {},
          "statement_descriptor": nil,
          "fraud_details" => {},
          "receipt_email" => nil,
          "receipt_number" => nil,
          "shipping" => nil,
          "application_fee" => nil,
          "refunds" => {
            "object" => "list",
            "total_count" => 0,
            "has_more" => false,
            "url" =>"/v1/charges/ch_15xHvdHHAbUnMwm5peHzAbFI/refunds",
            "data" => []
          }
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_69b7UoFDF2enHp",
      "api_version" => "2015-04-07"
    }
  end
  

  it 'deactivates use with the webhook data from stripe for a failed charge ', :vcr do 
    anesu = Fabricate(:user, customer_token: "cus_69ZARHVy1j4stH")
    post "/stripe_events", event_data
    expect(anesu.reload).not_to be_active 
  end
end
end
end
