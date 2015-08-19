Volontariat.BrainstormingController = Ember.Controller.extend(Volontariat.DestroyBrainstorming,
  actions:
    
    save: ->
      $.ajax(
        type: if @get('slug') then 'PUT' else 'POST'
        url: '/api/v1/brainstormings' + if @get('slug') then "/#{@get('slug')}" else '', 
        data: { brainstorming: { name: $('#brainstorming_name').val(), text: $('#brainstorming_text').val() } }
      ).success((data) =>
        @transitionToRoute 'brainstorming', @get('userSlug'), data.brainstorming.slug

        if data.errors
          alert "Something went wrong at saving brainstorming: #{JSON.stringify(data.errors)}"
        else
          alert 'Successfully saved brainstorming.'
      ).fail((data) =>
        alert "Something went wrong at saving brainstorming!"
      )
)