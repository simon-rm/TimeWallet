require "test_helper"

describe Timer do
  before { @timer = Timer.new }

  describe "#running?" do
    it "is false initially" do
      _(@timer.running?).must_equal false
    end

    it "becomes true after run!" do
      @timer.run!
      _(@timer.running?).must_equal true
    end

    it "becomes false after stop!" do
      @timer.run!
      @timer.stop!
      _(@timer.running?).must_equal false
    end
  end

  describe "#run!" do
    it "can't run if it's already running" do
      @timer.run!
      assert_raises(Timer::AlreadyRunningError) { @timer.run! }
    end
  end

  describe "#stop!" do
    it "can't stop upon creation" do
      assert_raises(Timer::NotRunningError) { @timer.stop! }
    end
    it "can't stop unless running" do
      @timer.run!
      @timer.stop!
      assert_raises(Timer::NotRunningError) { @timer.stop! }
    end
  end

  describe "#total_duration" do
    before { Timecop.freeze }
    after { Timecop.return }

    it "is 0 initially" do
      _(@timer.total_duration).must_equal 0
    end

    it "does not accumulate time upon creation" do
      Timecop.freeze(10.seconds)
      _(@timer.total_duration).must_equal 0
    end

    it "accumulates time while running" do
      @timer.run!
      Timecop.freeze(10.seconds)
      _(@timer.total_duration).must_equal 10.seconds
    end

    it "does not accumulate time while stopped" do
      @timer.run!
      Timecop.freeze(10.seconds)
      @timer.stop!
      Timecop.freeze(5.seconds)
      _(@timer.total_duration).must_equal 10.seconds
    end

    it "accumulates time while running again" do
      @timer.run!
      Timecop.freeze(10.seconds)
      @timer.stop!
      Timecop.freeze(5.seconds)
      @timer.run!
      Timecop.freeze(10.seconds)
      _(@timer.total_duration).must_equal 20.seconds
    end
  end
end
