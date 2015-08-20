Volontariat.BrainstormingController = Ember.Controller.extend(Volontariat.DestroyBrainstorming,
  ideas: [], newIdeaMode: false,
  
  anyIdeas: (-> @get('ideas').length > 0).property('ideas')
  
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

    newIdea: ->
      @set 'ideaId', null
      @set 'newIdeaMode', true
      
    leaveNewIdeaMode: ->
      @set 'newIdeaMode', false  
      
    editIdea: (id) ->
      @set 'newIdeaMode', false 
      @set 'ideaId', id
      
    leaveEditIdeaMode: ->
      @set 'ideaId', null
      
    destroyIdea: (ideaId, userId)  ->
      if Volontariat.User.current() == undefined || userId != Volontariat.User.current().id
        @transitionToRoute 'index'
        Volontariat.alert 'danger', 'Access denied!'
      else
        $.ajax("/api/v1/brainstorming_ideas/#{ideaId}", type: 'DELETE').done((data) =>
          @send 'reload'
        ).fail((data) ->
          Volontariat.alert 'danger', 'Removing item failed!'
        )  
      
    reload: ->
      @transitionToRoute 'no_data'
      @transitionToRoute 'brainstorming', @get('userSlug'), @get('slug')  
)