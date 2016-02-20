def assert test, msg = "Failed test"
  unless test then
    backtrace = caller.drop_while { |s| s =~ /#{__FILE__}/ }
    raise RuntimeError, msg, backtrace
  end
end

def assert_equal a, b
  assert a == b, "Failed assert_equal #{a} vs #{b}"
end
