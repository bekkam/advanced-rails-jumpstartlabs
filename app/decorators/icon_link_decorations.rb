# We can use modules and mix their methods into the decorator classes.
# Any other decorators that want to use this method can import the module
module IconLinkDecorations

    def delete_icon(link_text = nil)
        # called on model object, so that this method can be used polymorphically in article, comment, etc

        delete_icon_filename = 'cancel.png'
        h.link_to h.image_tag(delete_icon_filename) + link_text,
                  h.polymorphic_path(model),
                  method: :delete,
                  confirm: "Delete '#{model}'?"
    end

    def edit_icon(link_text = nil)
        edit_icon_filename = 'page_edit.png'
        h.link_to h.image_tag(edit_icon_filename) + " " + link_text,
                h.edit_polymorphic_path(model)
    end
end