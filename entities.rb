class Sketchup::Model
    def erase_entities(entities)
        # Because I've heard about (but not experienced) crashes relating
        # to using this on something other than the active entities
        # group.model.erase_entities(list_of_ents_or_single_ent)
        self.active_entities.erase_entities(entities)
    end
end

def Sketchup.erase_entities(entities)
    # Don't have to worry about what model you're working on
    return unless entities && entities[0]
    entities[0].model.erase_entities(entities)
end
