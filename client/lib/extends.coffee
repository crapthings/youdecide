#

_.extend Meteor,

	#

	signout: ->
		Meteor.logout (err) ->
			unless err
				Router.go 'home'
