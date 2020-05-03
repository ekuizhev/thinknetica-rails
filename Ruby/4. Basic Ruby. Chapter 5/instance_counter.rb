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
    # почему-то не инициализируется, приходится в методах
    # делать принудительную инициализацию, если не существует
    # class-level instance variable
    @instances = []

    def instances
      @instances ||= []
      @instances
    end
    
    protected
    
    def add_instance(instance)
      @instances ||= []
      @instances << instance
    end
  end
end
