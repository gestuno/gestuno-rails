require "stripe"

class ChargesController < ApplicationController
  before_action :stripe_params, only: [:create_source, :retrieve, :create_charge]

  def new
  end

  def create_source
    # *********** RECEIVE the payment-form from charges/new **********
    # FIRST, see if customer exists? && CHECK if USER has STRIPE_ID
    # IF NOT: create
    # Stripe::Customer.create({source: params[:stripeSource], email: current_user.email})
    # ELSE RETRIEVE CUSTOMER OBJECT & UPDATE W/ NEW SOURCE
    if current_user.customer? && current_user.stripe_id == nil
      customer = Stripe::Customer.create(
        :source => params[:stripeSource],
        :email => current_user.email
      )
      current_user.update(stripe_id: customer.id)
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.source = params[:stripeSource]
      customer.save
    end
    redirect_to dashboard_path
  end


  def create_charge
    # AFTER CALL: POST to create_charge w/ duration & call id
    # CALCULATE COST
    # USE STRIPE_ID to retrieve STRIP CUSTOMER OBJECT
    # CREATE stripe CHARGE w/ customer: user.stripe_id
    # UPDATE the call object as paid/unpaid, amount charged.
    @call = Call.find(session[:call_id])
    @duration = @call.duration
    @cost = (@duration * 1.5).to_i
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    charge = Stripe::Charge.create({
                                     amount: @cost,
                                     currency: 'aud',
                                     customer: current_user.stripe_id
    });

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
    if charge.status == "succeeded"
      "Payment was successful! You paid #{@cost}"
    else
      "Oops! This was not paid yet. Still owing #{@cost}"
    end
    # TODO SOPHIE TO FIX PATHS
    redirect_to dashboard_path
  end



  # def create
  # TODO SOPHIE - CARD ERROR

  # end

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

  #   debugger

  #   # Create a Customer:

  #   customer = Stripe::Customer.create({
  #                                        source: 'tok_mastercard',
  #                                        email: 'paying.user@example.com',
  #   })

  #   # Charge the Customer instead of the card:

  #   # YOUR CODE: Save the customer ID and other info in a database for later.

  #   # When it's time to charge the customer again, retrieve the customer ID.
  #   charge = Stripe::Charge.create({
  #                                    amount: 1500, # $15.00 this time
  #                                    currency: 'aud',
  #                                    customer: @user.stripe_id, # Previously stored, then retrieved
  #   })
  # end

  private

  def stripe_params
    Stripe.api_key = "sk_test_1AFHo24jEQ3jrA4xP5mRtwUK"
  end

end
