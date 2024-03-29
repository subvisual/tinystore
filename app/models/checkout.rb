class Checkout < ActiveRecord::Base

  belongs_to :store
  belongs_to :cart

  validates_presence_of :store, :cart, :client_name, :client_email
  validate :client_email, email: true
  validate :cart_is_not_empty

  after_create :send_emails

  def price
    cart.price
  end

  private

  def cart_is_not_empty
    errors.add(:cart, "is empty") if cart.items.empty?
  end

  def send_emails
    CheckoutMailer.to_store(self.id).deliver
    CheckoutMailer.to_client(self.id).deliver
  end

end
