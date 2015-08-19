Volontariat.User.reopenClass Volontariat.Singleton,
  createCurrent: ->
    userJson = PreloadStore.get("currentUser")
    
    return userJson
    
    # TODO: build record from JSON to save find query without posting it after next store commit
    #return Volontariat.__container__.lookup('store:main').createRecord(userJson) if userJson
    
    if userJson
      return Volontariat.__container__.lookup('store:main').query('user', userJson.id)
      
      Volontariat.__container__.lookup('store:main').query('user', userJson.id).then (current_user) ->
        Volontariat.currentUser = current_user
        
      return Volontariat.currentUser
    
    null