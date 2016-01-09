module AbstractInterface

  class InterfaceNotImplementedError < NoMethodError
  end

  def self.included(klass)
    klass.send(:include, AbstractInterface::Methods)
    klass.send(:extend, AbstractInterface::Methods)
    klass.send(:extend, AbstractInterface::ClassMethods)
  end

  module Methods

    def api_not_implemented(klass, method_name = nil)
      if method_name.nil?
        caller.first.match(/in \`(.+)\'/)
        method_name = $1
      end
      raise AbstractInterface::InterfaceNotImplementedError.new("#{klass.class.name} needs to implement '#{method_name}' for interface #{self.name}!")
    end

  end

  module ClassMethods

    def needs_implementation(name, *args)
      self.class_eval do
        define_method(name) do |*args|
          Bicycle.api_not_implemented(self, name)
        end
      end
    end

  end

end

class Bicycle
  include AbstractInterface

  needs_implementation :change_gear, :new_value
  needs_implementation :speed_up, :increment

  # Some documentation on the apply_brakes method
  def apply_brakes(decrement)
    # do some work here
  end

end

class AcmeBicycle < Bicycle
end

bike = AcmeBicycle.new
bike.change_gear(1) # AbstractInterface::InterfaceNotImplementedError: AcmeBicycle needs to implement 'change_gear' for interface Bicycle!
