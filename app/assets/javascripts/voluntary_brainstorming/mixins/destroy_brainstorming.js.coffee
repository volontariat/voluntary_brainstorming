Volontariat.DestroyBrainstorming = Em.Mixin.create
  actions:
    
    destroy: (user_slug, slug)  ->
      if Volontariat.User.current() == undefined || user_slug != Volontariat.User.current().slug
        @transitionToRoute 'index'
        Volontariat.alert 'danger', 'Access denied!'
      else
        $.ajax("/api/v1/brainstormings/#{slug}", type: 'DELETE').done((data) =>
          @transitionToRoute 'no_data'
          @transitionToRoute 'user_brainstormings', user_slug, 1 
        ).fail((data) ->
          Volontariat.alert 'danger', 'Removing item failed!'
        ) 