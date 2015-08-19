Volontariat.NewBrainstormingRoute = Ember.Route.extend
  controllerName: 'brainstorming'
  
  model: (params) ->
    @controllerFor('brainstorming').set 'userSlug', params.user_slug
