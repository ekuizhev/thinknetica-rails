module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    protected

    def register
      self.class.send :add_instance, self
    end
  end
  
  module ClassMethods
    def instances
      # class-level instance variable
      @instances ||= []
      @instances
    end

    protected

    def add_instance(instance)
      @instances << instance
    end
  end
end
