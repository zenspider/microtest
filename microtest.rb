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

class Reporter
  def report result
    unless result.failure? then
      print "."
    else
      failure = result.failure
      puts
      puts "Failure: #{result.class}##{result.name}: #{failure.message}"
      puts "  #{failure.backtrace.first}"
    end
  end

  def done
    puts
  end
end

class Test
  include Assertions

  TESTS = []

  def self.inherited x
    TESTS << x
  end

  def self.run_all_tests
    reporter = Reporter.new

    TESTS.each do |klass|
      klass.run reporter
    end

    reporter.done
  end

  def self.run reporter
    public_instance_methods.grep(/^test/).each do |name|
      e = self.new(name).run
      reporter.report e
    end
  end

  attr_accessor :name
  attr_accessor :failure
  alias failure? failure

  def initialize name
    self.name = name
    self.failure = false
  end

  def run
    # TODO: insert setup/teardown scaffolding here
    send name
  rescue => e
    self.failure = e
  ensure
    return self
  end
end
