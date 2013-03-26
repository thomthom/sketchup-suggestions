class Sketchup::Styles
    def load(path_or_file_like_object)
        # Not currently (easily) possible
        raise NotImplementedException.new('This feature is not implemented')
    end
    def erase_members!(definition_or_array_of_styles)
        # Bulk erase method. This should (if possible) be more efficient than
        # arr.each() {|d| e.erase! } (and take only one operation)
        definition_or_array_of_styles.each() {|d| d.erase! }
    end
end
class Sketchup::Style
    def save(path_or_file_like_object)
        # Not currently (easily) possible
        raise NotImplementedException.new('This feature is not implemented')
    end
    def erase!(replacement=false)
        # At the moment this is undefined. It should "purge" the style from
        #    the model.
        # Should this be the active style and replacement is not a
        #   Sketchup::Style instance, throw an exception
        # Should any pages using this style, the replacement argument is
        # considered:
        #     false = raise exception if in use
        #     nil = replace with default style
        #     Sketchup::Style instance = replace with given style
        # This could also be aliased as purge!, although possibly removing the
        # optional argument
        raise NotImplementedException.new('This feature is not implemented')
    end
end
