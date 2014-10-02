module Payola
  class CreateSale
    def self.call(params, product, coupon, affiliate)
      Payola::Sale.new do |s|
        s.product = product
        s.email = params[:email]
        s.stripe_token = params[:stripeToken] || params[:stripe_token]
        s.affiliate_id = affiliate.try(:id)
  
        if coupon
          s.coupon = coupon
          s.amount = product.price * (1 - s.coupon.percent_off / 100.0)
        else
          s.amount = product.price
        end
      end
    end
  end
end