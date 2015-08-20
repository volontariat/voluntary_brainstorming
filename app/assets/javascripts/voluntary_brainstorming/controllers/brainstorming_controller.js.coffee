Volontariat.BrainstormingController = Ember.Controller.extend(Volontariat.DestroyBrainstorming,
  actions:
    
    save: ->
      $.ajax(
        type: if @get('slug') then 'PUT' else 'POST'
        url: '/api/v1/brainstormings' + if @get('slug') then "/#{@get('slug')}" else '', 
        data: { brainstorming: { name: $('#brainstorming_name').val(), text: $('#brainstorming_text').val() } }
      ).success((data) =>
        if data.errors
          Volontariat.alert 'danger', "Something went wrong at saving brainstorming: #{JSON.stringify(data.errors)}"
        else
          @transitionToRoute 'brainstorming', @get('userSlug'), data.brainstorming.slug
          Volontariat.alert 'success', 'Successfully saved brainstorming.'
      ).fail((data) =>
        Volontariat.alert 'danger', "Something went wrong at saving brainstorming!"
      )
)