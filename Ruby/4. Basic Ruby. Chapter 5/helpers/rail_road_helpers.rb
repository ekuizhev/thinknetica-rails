module RailRoadHelpers
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
  end

  module ClassMethods
  end
end
