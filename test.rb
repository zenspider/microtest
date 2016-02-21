require "./microtest.rb"

def should_fail
  yield
  abort "BAD RUN!"
rescue
  # good, we should have raised
end

class TestAssertions < Test
  def test_assert
    assert true

    should_fail { assert false }
  end

  def test_assert_equal
    assert_equal 4, 2+2

    should_fail { assert_equal 5, 2+2 }
  end

  def test_assert_in_delta
    assert_in_delta 0.0001, 0.0002

    should_fail { assert_in_delta 0.5, 0.6 }
  end
end

Test.run_all_tests
