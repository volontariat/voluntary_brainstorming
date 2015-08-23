Volontariat.BrainstormingController = Ember.Controller.extend(Volontariat.DestroyBrainstorming,
  ideas: [], newIdeaMode: false, newArgumentIdeaId: null, argumentId: null
  
  anyIdeas: (-> @get('ideas').length > 0).property('ideas')
  
  actions:
    
    setDirty: ->
      @set 'dirty', true
      setTimeout (=>
        @set 'dirty', false
      ), 3000
    
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
 
    newArgument: (ideaId) ->
      @set 'newArgumentIdeaId', ideaId
      @set 'argumentId', null
      
    editArgument: (id, pro, contra, neutral) ->
      @set 'newArgumentIdeaId', null 
      @set 'argumentId', id 
      
      setTimeout (->
        if pro
          $('input[name="argument[vote]"][value="1"]').click()
        else if contra
          $('input[name="argument[vote]"][value="0"]').click()
        else if neutral
          $('input[name="argument[vote]"][value=""]').click()
      ), 100
      
    leaveComposeArgumentMode: ->
      @set 'newArgumentIdeaId', null
      @set 'argumentId', null
      
    destroyIdea: (ideaId, userId)  ->
      @send 'setDirty'
      
      if Volontariat.User.current() == undefined || userId != Volontariat.User.current().id
        alert 'Access denied!'
      else
        $.ajax("/api/v1/brainstorming_ideas/#{ideaId}", type: 'DELETE').done((data) =>
          @send 'reload'
          alert 'Successfully removed idea.'
        ).fail((data) ->
          alert 'Removing idea failed!'
        )  
      
    reload: ->
      @transitionToRoute 'no_data'
      @transitionToRoute 'brainstorming', @get('userSlug'), @get('slug')  
)