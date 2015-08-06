Template.newTopic.events

	'submit form': (e, t) ->
		e.preventDefault()
		title = ($ t.find '.title').val()
		Meteor.call 'newTopic', title, (err, res) ->
			unless err
				Router.go 'viewTopic', { _id: res }
