class ChargesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    # Amount in cents
    #   @amount = 150

    #   customer = Stripe::Customer.create(
    #     :email => params[:stripeEmail],
    #     :source  => params[:stripeToken]
    #   )

    #   charge = Stripe::Charge.create(
    #     :customer    => customer.id,
    #     :amount      => @amount,
    #     :description => 'Create your Stripe Payment Account here',
    #     :currency    => 'AUD'
    #   )

    # rescue Stripe::CardError => e
    #   flash[:error] = e.message
    #   redirect_to new_charge_path
    # end


    Stripe.api_key = "sk_test_1AFHo24jEQ3jrA4xP5mRtwUK"

    # Token is created using Checkout or Elements!
    # Get the payment token ID submitted by the form:
    token = params[:stripeToken]

    charge = Stripe::Charge.create({
                                     amount: 150,
                                     currency: 'AUD',
                                     description: 'Example charge',
                                     source: token
    });

    Stripe.api_key = "sk_test_1AFHo24jEQ3jrA4xP5mRtwUK"

    # Create a Customer:
    customer = Stripe::Customer.create({
                                         source: 'tok_mastercard',
                                         email: 'paying.user@example.com',
    })

    # Charge the Customer instead of the card:
    charge = Stripe::Charge.create({
                                     amount: 1000,
                                     currency: 'aud',
                                     customer: customer.id,
    })

    # YOUR CODE: Save the customer ID and other info in a database for later.

    # When it's time to charge the customer again, retrieve the customer ID.
    charge = Stripe::Charge.create({
                                     amount: 1500, # $15.00 this time
                                     currency: 'aud',
                                     customer: customer_id, # Previously stored, then retrieved
    })

  end

end
