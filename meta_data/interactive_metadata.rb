$interactive_metadata = {
  title: {
    required: true
  },

  publicationStatus: {
    defaultValue: "public"
  },

  subtitle: {
    defaultValue: ""
  },

  about: {
    defaultValue: ""
  },

  fontScale: {
    defaultValue: 1
  },

  models: {
    # List of model definitions. Its definition is below ('model').
    required: true
  },

  parameters: {
    # List of custom parameters.
    defaultValue: []
  },

  outputs: {
    # List of outputs.
    defaultValue: []
  },

  filteredOutputs: {
    # List of filtered outputs.
    defaultValue: []
  },

  exports: {
    required: false
  },

  components: {
    # List of the interactive components. Their definitions are below ('button', 'checkbox' etc.).
    defaultValue: []
  },

  layout: {
    # Layout definition.
    defaultValue: {}
  },

  template: {
    # Layout template definition.
    defaultValue: "simple"
  }

}
