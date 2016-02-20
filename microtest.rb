def assert test
  unless test then
    backtrace = caller.drop_while { |s| s =~ /#{__FILE__}/ }
    raise RuntimeError, "Failed test", backtrace
  end
end

def assert_equal a, b
  assert a == b
end
