def assert test
  raise RuntimeError, "Failed test", caller unless test
end
