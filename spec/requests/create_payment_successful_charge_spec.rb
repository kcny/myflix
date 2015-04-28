require "spec_helper"

describe "Create Payment On Successful Charge" do
  let(:event_data) do
    {
      "id" => "evt_15wZ8OHHAbUnMwm5uh4a4uq5",
      "created" => 1430229144,
      "livemode" => false,
      "type" => "charge.succeeded",
      "data" => {
        "object" => {
          "id" => "ch_15wZ8NHHAbUnMwm5bwh5JLVi",
          "object" => "charge",
          "created" => 1430229143,
          "livemode" => false,
          "paid" => true,
          "status" => "succeeded",
          "amount" => 999,
          "currency" => "usd",
          "refunded" => false,
          "source" => {
            "id" => "card_15wZ8NHHAbUnMwm5WJrLlSrW",
            "object" => "card",
            "last4" => "4242",
            "brand" => "Visa",
            "funding" => "credit",
            "exp_month" => 4,
            "exp_year" => 2019,
            "fingerprint" => "SuiyRbzExKOVUyWW",
            "country" => "US",
            "name" => nil,
            "address_line1" => nil,
            "address_line2" => nil,
            "address_city" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_country" => nil,
            "cvc_check" => "pass",
            "address_line1_check" => nil,
            "address_zip_check" => nil,
            "dynamic_last4" => nil,
            "metadata" => {},
            "customer" => "cus_68qqodmxakznOC"
          },
          "captured" => true,
          "balance_transaction" => "txn_15wZ8OHHAbUnMwm5Mm9ucp4A",
          "failure_message" => nil,
          "failure_code" => nil,
          "amount_refunded" => 0,
          "customer" => "cus_68qqodmxakznOC",
          "invoice" => "in_15wZ8NHHAbUnMwm5T8B8Zr8Z",
          "description" => nil,
          "dispute" => nil,
          "metadata" => {},
          "statement_descriptor" => nil,
          "fraud_details" => {},
          "receipt_email" => nil,
          "receipt_number" => nil,
          "shipping" => nil,
          "application_fee" => nil,
          "refunds" => {
            "object" => "list",
            "total_count" => 0,
            "has_more" => false,
            "url" => "/v1/charges/ch_15wZ8NHHAbUnMwm5bwh5JLVi/refunds",
            "data" => []
          }
        }
      },
      "object" => "event",
      "pending_webhooks" => 1,
      "request" => "iar_68qqb9jzzHpoXk",
      "api_version" => "2015-04-07"
    } 
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1) 
  end
end