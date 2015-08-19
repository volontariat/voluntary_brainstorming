Volontariat.UserBrainstormingsRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('user_brainstormings').set 'metadata', {}
    @controllerFor('user_brainstormings').set 'userSlug', params.user_slug
    @controllerFor('user_brainstormings').set 'page', params.page
    
    @store.findRecord('user', params.user_slug).then (user) =>
      @controllerFor('user_brainstormings').set 'userName', user.get('name')
    
    Ember.$.getJSON(
      "/api/v1/brainstormings.json?user_slug=#{params.user_slug}"
    ).then (json) =>
      @controllerFor('user_brainstormings').set 'metadata', json.meta
      @controllerFor('user_brainstormings').set 'brainstormings', json.brainstormings
    
      { name: params.user_name }

  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)