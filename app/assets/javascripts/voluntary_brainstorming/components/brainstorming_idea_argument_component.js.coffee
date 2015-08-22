Volontariat.BrainstormingIdeaArgumentComponent = Ember.Component.extend
  tagName: 'tr'
  
  composeMode: (-> 
    (@get('selectedNewArgumentIdeaId') != undefined && @get('selectedNewArgumentIdeaId') == @get('ideaId')) || (@get('selectedId') != undefined && @get('selectedId') == @get('id'))
  ).property('selectedNewArgumentIdeaId', 'ideaId', 'selectedId', 'id')
  
  pro: (-> @get('argument').vote == true).property('argument')
  contra: (-> @get('argument').vote == false).property('argument')
  neutral: (-> @get('argument').vote == null).property('argument')
  
  actions:
    
    new: (ideaId) ->
      @sendAction 'newAction', ideaId
     
    edit: (id) ->
      @sendAction 'editAction', id, @get('pro'), @get('contra'), @get('neutral')
      
    cancel: ->
      @sendAction 'leaveComposeArgumentModeAction'
      
    save: ->
      $.ajax(
        type: if @get('id') then 'PUT' else 'POST'
        url: '/api/v1/arguments' + if @get('id') then "/#{@get('id')}" else '', 
        data: { 
          argument: { 
            argumentable_type: 'BrainstormingIdea', argumentable_id: @get('ideaId'),
            vote: $('input[name="argument[vote]"]:checked').val(),
            topic_name: $('#argument_topic_name').val(), value: $('#argument_value').val() 
          } 
        }
      ).success((data) =>
        if data.errors
          alert "Something went wrong at saving argument: #{JSON.stringify(data.errors)}"
        else
          @sendAction 'leaveComposeArgumentModeAction'
          
          unless @get('id')
            @set 'topicName', ''
            @set 'value', ''
          
          @sendAction 'reloadAction'
          alert 'Successfully saved argument.'
      ).fail((data) =>
        alert "Something went wrong at saving argument!"
      )  
      
    destroy: (id)  ->
      if Volontariat.User.current() == undefined || @get('argument').user_id != Volontariat.User.current().id
        alert 'Access denied!' + @get('argument').user_id + ',' + Volontariat.User.current().id
      else
        $.ajax("/api/v1/arguments/#{id}", type: 'DELETE').done((data) =>
          @sendAction 'reloadAction'
          alert 'Successfully removed argument.'
        ).fail((data) ->
          Volontariat.alert 'Removing argument failed!'
        )  