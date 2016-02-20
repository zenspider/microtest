def assert test
  raise RuntimeError, "Failed test", caller unless test
end

def assert_equal a, b
  assert a == b
end
