#

Meteor.users.helpers

	displayName: ->
		@profile?.displayName or @username

#

Meteor.users.before.insert (userId, user) ->
	_.extend user,
		profile:
			avatarHash: user.profile?.avatarHash or CryptoJS.MD5(user.username).toString()

#

Meteor.users.after.insert ->
	System.update { init: true },
		$inc:
			'stats.users': 1

#

Meteor.methods

	updateProfile: (opt) ->

		profile = opt.profile?

		Meteor.users.update Meteor.userId(),
			$set:
				profile: profile
				updatedAt: new Date()

#

if Meteor.isServer

	#

	Meteor.publish '', ->
		unless @userId
			@ready()

		Meteor.users.find { _id: @userId },
			fields:
				services: false
