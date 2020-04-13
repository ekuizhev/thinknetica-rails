require 'set'

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    protected

    def register_instance
      raise "Dublicat error" if self.class.instances.include?(self) 
      self.class.send :add_instance, self
    end
  end
  
  module ClassMethods
    def instances
      # class-level instance variable
      @instances ||= Set.new
      @instances.to_a
    end

    protected

    def add_instance(instance)
      @instances.add(instance)
    end
  end
end
