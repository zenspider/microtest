require "./microtest.rb"

class TestAssertions < Test
  def test_assert
    assert true
  end

  def test_assert_bad
    assert false
  end

  def test_assert_equal
    assert_equal 4, 2+2
  end

  def test_assert_equal_bad
    assert_equal 5, 2+2
  end

  def test_assert_in_delta
    assert_in_delta 0.0001, 0.0002
  end

  def test_assert_in_delta_bad
    assert_in_delta 0.5, 0.6
  end
end

Test.run_all_tests
