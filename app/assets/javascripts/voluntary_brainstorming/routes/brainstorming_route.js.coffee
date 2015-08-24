Volontariat.BrainstormingRoute = Ember.Route.extend
  model: (params) ->
    $('#reload_alert').slideUp()
    
    #@controllerFor('brainstorming').set 'reloading', false
    
    MessageBus.subscribe "/brainstormings/#{params.slug}", (data) =>
      #if @controllerFor('brainstorming').get('reloading')
      #  alert 'reloading still active'
      #else if (
      return if Volontariat.User.current() != undefined && data.author_id == Volontariat.User.current().id
      
      if ( 
        @controllerFor('brainstorming').get('newIdeaMode') || @controllerFor('brainstorming').get('ideaId') || 
        @controllerFor('brainstorming').get('newArgumentIdeaId') || @controllerFor('brainstorming').get('argumentId')
      )
        Volontariat.reload_alert data.message
      else
        #@controllerFor('brainstorming').set 'reloading', true
        @transitionTo 'no_data'
        @transitionTo 'brainstorming', params.user_slug, params.slug 
  
    @controllerFor('brainstorming').set 'slug', params.slug
    @controllerFor('brainstorming').set 'userSlug', params.user_slug
    @controllerFor('brainstorming').set 'ideaId', null
    
    Ember.$.getJSON(
      "/api/v1/brainstorming_ideas.json?user_slug=#{params.user_slug}&brainstorming_slug=#{params.slug}"
    ).then (json) =>
      @controllerFor('brainstorming').set 'ideas', json.brainstorming_ideas
    
    Ember.$.getJSON("/api/v1/brainstormings/#{params.slug}?user_slug=#{params.user_slug}").then (json) =>
      json.brainstorming
      
  closeReloadAlert: (->
    $('#reload_alert').slideUp()
  ).on('deactivate')