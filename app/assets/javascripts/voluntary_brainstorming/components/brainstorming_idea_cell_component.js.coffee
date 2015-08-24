Volontariat.BrainstormingIdeaCellComponent = Ember.Component.extend
  editMode: (-> @get('selectedId') == @get('ideaId')).property('selectedId', 'ideaId')

  actions:
    
    cancel: ->
      @sendAction 'leaveEditIdeaModeAction'
    
    save: ->
      $.ajax(
        type: if @get('ideaId') then 'PUT' else 'POST'
        url: '/api/v1/brainstorming_ideas' + if @get('ideaId') then "/#{@get('ideaId')}" else '', 
        data: { 
          user_slug: @get('userSlug'), brainstorming_slug: @get('slug'),
          brainstorming_idea: { 
            name: $('#brainstorming_idea_name').val(), text: $('#brainstorming_idea_text').val() 
          } 
        }
      ).success((data) =>
        if data.errors
          alert "#{Volontariat.t('brainstorming_ideas.save.failed')}: #{JSON.stringify(data.errors)}"
        else
          unless @get('ideaId')
            @sendAction 'leaveNewIdeaModeAction'
            @set 'ideaName', ''
            @set 'ideaText', ''
          
          @sendAction 'reloadAction'
          alert Volontariat.t('brainstorming_ideas.save.successful')
      ).fail((data) =>
        alert "#{Volontariat.t('brainstorming_ideas.save.failed')}!"
      )  