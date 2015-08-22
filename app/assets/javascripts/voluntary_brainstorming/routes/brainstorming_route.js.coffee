Volontariat.BrainstormingRoute = Ember.Route.extend
  model: (params) ->
    faye = new Faye.Client("http://localhost:9292/faye")
    
    faye.subscribe "/brainstormings/#{params.slug}", (data) ->
      alert JSON.stringify(data)
    
    @controllerFor('brainstorming').set 'slug', params.slug
    @controllerFor('brainstorming').set 'userSlug', params.user_slug
    @controllerFor('brainstorming').set 'ideaId', null
    
    Ember.$.getJSON(
      "/api/v1/brainstorming_ideas.json?user_slug=#{params.user_slug}&brainstorming_slug=#{params.slug}"
    ).then (json) =>
      @controllerFor('brainstorming').set 'ideas', json.brainstorming_ideas
    
    Ember.$.getJSON("/api/v1/brainstormings/#{params.slug}?user_slug=#{params.user_slug}").then (json) =>
      json.brainstorming