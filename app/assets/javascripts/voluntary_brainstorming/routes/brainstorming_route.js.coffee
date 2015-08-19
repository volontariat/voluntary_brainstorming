Volontariat.BrainstormingRoute = Ember.Route.extend
  model: (params) ->
    Ember.$.getJSON("/api/v1/brainstormings/#{params.slug}?user_slug=#{params.user_slug}").then (json) =>
      json.brainstorming