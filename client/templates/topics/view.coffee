#

Template.viewTopic.events

	#

	'submit #leftForm': (e, t) ->
		e.preventDefault()
		$leftContent = ($ t.find '.leftContent').val()
		Meteor.call 'commentLeft', @_id, $leftContent, (err) ->
			unless err
				($ t.find '.leftContent').val ''

	#

	'submit #rightForm': (e, t) ->
		e.preventDefault()
		$rightContent = ($ t.find '.rightContent').val()
		Meteor.call 'commentRight', @_id, $rightContent, (err) ->
			unless err
				($ t.find '.rightContent').val ''

#

Template.commentItem.rendered = ->
	_.delay ->
		jdenticon()
	, 100
