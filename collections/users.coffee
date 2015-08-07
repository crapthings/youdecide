#

Meteor.users.after.insert ->
	System.update { init: true },
		$inc:
			'stats.users': 1

#

if Meteor.isServer

	#

	Meteor.publish '', ->
		unless @userId
			@ready()

		Meteor.users.find { _id: @userId },
			fields:
				services: false
