class Sketchup::AttributeDictionary
    def to_h(h={})
        # Copy into a hash
        for k, v in self
            h[k] = v
        end
        return h
    end unless self.instance_method(:to_h)

    def merge!(other)
        for k, v in other
            self[k] = v
        end
    end
end

class Sketchup::AttributeDictionaries
    def to_h(h={})
        # Copy into a hash
        for k, v in self
            h[k] = v.to_h
        end
        return h
    end unless self.instance_method(:to_h)
end

class AttributeHashLike < Hash
    # Used for Attributer#with_entity. Haven't tested if this gives any
    # benefit at all, but I assume there will be if the same values are read
    # a few times, otherwise the initialization and caching cost will probably
    # add time, YMMV. Hand-written memoization will also be more performant.
    attr_reader :attributer, :entity
    def initialize(attributer, entity, *args)
        set = Hash.instance_method("[]=").bind(self)
        super(*args) {|h, k|
            set.call(k, attributer.get_attribute(entity, k))
        }
        @attributer = attributer
        @entity = @entity
    end
    def []=(k, v, *args, &block)
        attributer.set_attribute(entity, k, v)
        super(k, v, *args, &block)
    end
end

class Attributer
    # For attribute dictionaries, it's more manageable to operate on this than
    # each entity, because it avoids having to plaster the dictionary name
    # all over the place (either directly or through constants)
    # Example:
    # module Auther
    #   Attr = Attributer.new('auther')
    #   module Plugin
    #     Attr = Auther::Attr.get_child('plugin')
    #     # ...
    #     Attr.set_attribute(Sketchup.active_model, 'some_key', some_value)
    #     # => Sketchup.active_model.set_attribute('author/plugin', 'some_key', some_value)
    #   end
    # end

    attr_reader :scope
    def initialize(scope)
        @scope = scope
    end

    def set_attribute(entity, key, value)
        entity.set_attribute(scope, key, value)
    end
    def get_attribute(entity, key, default=nil)
        return entity.get_attribute(scope, key, default)
    end

    def bulk_set_attribute(entity, h={})
        for k, v in h
            set_attribute(entity, k, v)
        end
    end
    def to_h(entity)
        dict = entity.attribute_dictionary(scope)
        return dict.to_h unless dict.nil?
        return {}
    end
    def get_child(scope)
        return self.class.new(@scope + '/' + scope)
    end
    def delete_from(entity)
        entity.attribute_dictionaries.delete(scope)
    end

    def with_entity(entity)
        # Allow for bulk access to a single entity
        # e.g.,
        # result = Attr.with_entity(Sketchup.active_model) {|ent|
        #    ent['name'] = 'Default' unless ent['name']
        # }
        return yield(AttributeHashLike.new(self, entity))
    end
end
