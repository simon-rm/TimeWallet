require "test_helper"

describe Day do
  before do
    @day = Day.create!(user: User.first)
    @day.timers = Timer.first(3)
  end

  describe "#current_timer" do
    it "returns nil if no timer is running" do
      _(@day.current_timer).must_be_nil
    end
  end

  describe "#switch_to!" do
    it "sets the current timer" do
      @day.switch_to!(:life)
      @day.reload
      _(@day.current_timer.name).must_equal "life"
    end

    describe "When called after the day finishes" do
      it "raises SwitchAfterFinishError" do
        @day.update finished_at: Time.current

        assert_raises(Day::SwitchAfterFinishError) { @day.switch_to!(:life) }
      end
    end

    describe "when called with nil" do
      it "unsets current timer" do
        @day.switch_to!(nil)
        _(@day.current_timer).must_be_nil
      end
    end

    describe "when called with nonexistent name" do
      it "raises ArgumentError" do
        assert_raises(ActiveRecord::RecordNotFound) { @day.switch_to!(:foo) }
      end
    end

    describe "when called with current timer name" do
      it "raises ArgumentError" do
        @day.switch_to!(:life)
        @day.reload
        assert_raises(ActiveRecord::RecordNotFound) { @day.switch_to!(:life) }
      end
    end
  end
end
