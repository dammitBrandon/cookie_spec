require 'rspec'

require_relative 'cookie'

describe Cookie do

  let(:type)   { "peanut butter" }
  let(:cookie) { Cookie.new(type) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Cookie of the specified type" do
        cookie.type.should eq(type)
      end
    end

    context "with invalid input" do
      it "throws an argument error when not given a type argument" do
        expect { Cookie.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#type" do
    context "with invalid input" do
      it "returns the type of the cookie" do
          cookie.type.should eq(type)
      end
    end
  end

  describe "#bake!" do
    it "requires an integer time argument" do
      expect { cookie.bake!("10")}.to raise_error(TypeError)
    end

    it "returns the cookie object" do
      cookie.bake!(10).should eq(cookie)
    end

    it "changes the status of the cookie when given enough time" do
      expect { cookie.bake!(10) }.to change(cookie, :status)
    end
  end

  describe "#status" do
    it "returns the cookie's current status" do
      expect { cookie.bake!(7) }.to change(cookie, :status)
    end

    context "when unbaked" do
      it "is `:doughy`" do
        cookie.bake!(6).status.should eq(:doughy)
      end
    end

    context "when baked for less than 7 minutes" do
      it "is `:doughy`" do
        cookie.bake!( rand(7) ).status.should eq(:doughy)
      end
    end

    context "when baked for at least 7 but less than 10 minutes" do
      it "is `:almost_ready`" do
        cookie.bake!( rand(7..9) ).status.should eq(:almost_ready)
      end
    end

    context "when baked for at least 10 but less than 12 minutes" do
      it "is `:ready`" do
        cookie.bake!( rand(10..12) ).status.should eq(:ready)
      end
    end

    context "when baked for at least 12 minutes" do
      it "is `:burned`" do
        cookie.bake!( 12 ).status.should eq(:burned)
      end
    end
  end
end
