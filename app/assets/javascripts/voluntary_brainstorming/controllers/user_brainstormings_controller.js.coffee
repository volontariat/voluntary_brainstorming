Volontariat.UserBrainstormingsController = Ember.Controller.extend(Volontariat.HasCurrentUser, Volontariat.PaginationController, Volontariat.DestroyBrainstorming,
  brainstormings: [], paginationResource: null, paginationRoute: 'user_brainstormings'
  
  anyBrainstormings: (-> @get('brainstormings').length > 0).property('brainstormings')
)