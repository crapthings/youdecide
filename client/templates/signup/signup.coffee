Template.signup.events

	'submit form': (e, t) ->
		e.preventDefault()
		opt =
			username: ($ t.find '.username').val()
			password: ($ t.find '.password').val()
		Accounts.createUser opt, (err) ->
			unless err
				Router.go 'home'
			else
				Session.set 'errorMessage', err.reason
