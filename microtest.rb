module Assertions
  def assert test, msg = "Failed test"
    unless test then
      backtrace = caller.drop_while { |s| s =~ /#{__FILE__}/ }
      raise RuntimeError, msg, backtrace
    end
  end

  def assert_equal a, b
    assert a == b, "Failed assert_equal #{a} vs #{b}"
  end

  def assert_in_delta a, b
    assert (a-b).abs <= 0.001, "Failed assert_in_delta #{a} vs #{b}"
  end
end

class Test
  include Assertions

  TESTS = []

  def self.inherited x
    TESTS << x
  end

  def self.run_all_tests
    TESTS.each do |klass|
      klass.run
    end
    puts
  end

  def self.run
    public_instance_methods.grep(/^test/).each do |name|
      begin
        self.new.run name
        print "."
      rescue => e
        puts
        puts "Failure: #{self}##{name}: #{e.message}"
        puts "  #{e.backtrace.first}"
      end
    end
  end

  def run name
    # TODO: insert setup/teardown scaffolding here
    send name
  end
end
