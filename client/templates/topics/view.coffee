#

Template.viewTopic.events

	#

	'submit #leftForm': (e, t) ->
		e.preventDefault()
		$leftContent = ($ t.find '.leftContent').val()
		Meteor.call 'commentLeft', @_id, $leftContent, (err) ->
			unless err
				($ t.find '.leftContent').val ''
				autosize($ 'textarea')

	'keyup .leftContent': (e, t) ->
		e.preventDefault()
		if e.keyCode is 13 and e.shiftKey
			($ '#leftForm').trigger 'submit'

	#

	'submit #rightForm': (e, t) ->
		e.preventDefault()
		$rightContent = ($ t.find '.rightContent').val()
		Meteor.call 'commentRight', @_id, $rightContent, (err) ->
			unless err
				($ t.find '.rightContent').val ''
				autosize($ 'textarea')

	'keyup .rightContent': (e, t) ->
		e.preventDefault()
		if e.keyCode is 13 and e.shiftKey
			($ '#rightForm').trigger 'submit'

	'click .method-like-topic': (e, t) ->
		e.preventDefault()
		console.log @
		Meteor.call 'likeTopic', @_id

#

Template.commentItem.rendered = ->
	_.delay ->
		jdenticon()
	, 100


Template.viewTopic.helpers

	rbRatio: ->
		if @topic.stats?.left is @topic.stats?.right
			0.5
		else
			((@topic.stats?.left / (@topic.stats?.left + @topic.stats?.right)).ceil(2))
