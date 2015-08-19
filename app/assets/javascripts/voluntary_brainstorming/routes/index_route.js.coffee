Volontariat.IndexRoute = Ember.Route.extend
  model: (params) ->
    unless Volontariat.User.current() == undefined
      @transitionTo 'user_brainstormings', Volontariat.User.current().slug, 1