Volontariat.BrainstormingIdeaVoteComponent = Ember.Component.extend
  actions:
    up: ->
      if Volontariat.User.current() == undefined
        alert Volontariat.t('general.exceptions.access_denied')
        
        return
        
      @set 'count', @get('count') + 1
      @set 'vote', true
      
      @sendAction 'setDirtyAction'
      
      $.ajax(type: 'POST', url: '/api/v1/brainstorming_idea_votes', data: { idea_id: @get('ideaId') }).success((data) =>
        if data.errors
          alert "#{Volontariat.t('brainstorming_idea_votes.create.failed')}: #{JSON.stringify(data.errors)}"
          @set 'count', @get('count') - 1
          @set 'vote', false
        else
          @sendAction 'reloadAction'
          alert Volontariat.t('brainstorming_idea_votes.create.successfully')
      ).fail((data) =>
        alert "#{Volontariat.t('brainstorming_idea_votes.create.failed')}!"
        @set 'count', @get('count') - 1
        @set 'vote', false
      )  
      
    down: ->
      if Volontariat.User.current() == undefined
        alert Volontariat.t('general.exceptions.access_denied')
        
        return
      
      @set 'count', @get('count') - 1
      @set 'vote', false
    
      @sendAction 'setDirtyAction'
      
      $.ajax("/api/v1/brainstorming_idea_votes/0", type: 'DELETE', data: { idea_id: @get('ideaId') }).done((data) =>
        @sendAction 'reloadAction'
        alert Volontariat.t('brainstorming_idea_votes.destroy.successful')
      ).fail((data) =>
        alert Volontariat.t('activerecord.errors.models.brainstorming_idea_vote.attributes.base.deletion_failed')
        @set 'count', @get('count') + 1
        @set 'vote', true
      )  