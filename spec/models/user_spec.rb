require 'spec_helper'

describe User do
  context 'devise shim' do
    Given(:user) { User.new }
    Then { expect(user.password_required?).to eq false }
    And { expect(user.email_required?).to eq false }
    And { expect(user).to respond_to(:password) }
    And { expect(user).to respond_to(:password=) }
    And { expect(user).to respond_to(:update_with_password) }
  end
end
