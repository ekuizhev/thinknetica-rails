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
    # class-level instance variable not initializing here
    @instances = []

    def instances
      # force initialize for the first time
      @instances ||= []
      @instances
    end

    protected

    def add_instance(instance)
      # and too force initialize
      @instances ||= []
      @instances << instance
    end
  end
end
