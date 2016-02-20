require "./microtest.rb"

def should_fail
  yield
  abort "BAD RUN!"
rescue
  # good, we should have raised
end

assert true

should_fail { assert false }

assert_equal 4, 2+2

should_fail { assert_equal 5, 2+2 }

assert_in_delta 0.0001, 0.0002

should_fail { assert_in_delta 0.5, 0.6 }
