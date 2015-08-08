Template.ui_header.events

	'submit form': (e, t) ->
		e.preventDefault()
		$username = ($ t.find '.username').val()
		$password = ($ t.find '.password').val()
		Meteor.loginWithPassword $username, $password, (err) ->
			unless err
				Router.go 'home'

	'click .randomTopic': (e, t) ->
		e.preventDefault()
		Meteor.call 'findRandomTopic', (err, res) ->
			unless err
				Router.go 'viewTopic', { _id: res }
