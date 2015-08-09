Template.profile.events

	'submit form': (e, t) ->
		e.preventDefault()
		console.log @
		opt = form2js 'profileForm'
		Meteor.call 'updateProfile', opt
