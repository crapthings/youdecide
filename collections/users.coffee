#

Meteor.users.helpers

	displayName: ->
		@profile?.displayName or @username

#

Meteor.users.before.insert (userId, user) ->
	_.extend user,
		profile:
			avatarHash: user.profile?.avatarHash or CryptoJS.MD5('demo').toString()

#

Meteor.users.after.insert ->
	System.update { init: true },
		$inc:
			'stats.users': 1

#

Meteor.methods

	updateProfile: (opt) ->
		Meteor.users.update Meteor.userId(),
			$set: opt

#

if Meteor.isServer

	#

	Meteor.publish '', ->
		unless @userId
			@ready()

		Meteor.users.find { _id: @userId },
			fields:
				services: false
