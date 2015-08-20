Volontariat.EditBrainstormingRoute = Ember.Route.extend
  controllerName: 'brainstorming'
  
  model: (params) ->
    if Volontariat.User.current() == undefined || params.user_slug != Volontariat.User.current().slug
      @transitionTo 'index'
      Volontariat.alert 'danger', 'Access denied!'
    else
      @controllerFor('brainstorming').set 'userSlug', params.user_slug
      @controllerFor('brainstorming').set 'slug', params.slug
      
      Ember.$.getJSON("/api/v1/brainstormings/#{params.slug}?user_slug=#{params.user_slug}").then (json) =>
        @controllerFor('brainstorming').set 'name', json.brainstorming.name
        @controllerFor('brainstorming').set 'text', json.brainstorming.text
        
        json.brainstorming