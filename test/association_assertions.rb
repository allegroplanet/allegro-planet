module Minitest
  module Assertions
    def assert_association(klass, association_type, property)
      assert klass.reflect_on_all_associations(association_type).select { |a| a.name == property }.one?
    end
  end
end
