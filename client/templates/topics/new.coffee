Template.newTopic.events

	'submit form': (e, t) ->
		e.preventDefault()
		opt = form2js 'topicForm'
		Meteor.call 'newTopic', opt, (err, res) ->
			unless err
				Router.go 'viewTopic', { _id: res }
