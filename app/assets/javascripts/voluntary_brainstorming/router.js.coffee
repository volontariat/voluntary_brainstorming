Volontariat.Router.reopen location: 'hash'

Volontariat.Router.map ->
  @_super
  
  @route 'user_brainstormings', path: '/users/:user_slug/brainstormings/page/:page'
  @route 'brainstorming', path: '/users/:user_slug/brainstormings/:slug'
  @route 'new_brainstorming', path: '/users/:user_slug/brainstormings/new'
  @route 'edit_brainstorming', path: '/users/:user_slug/brainstormings/:slug/edit'