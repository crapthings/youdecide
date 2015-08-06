#

@System = new Mongo.Collection 'system'

#

if Meteor.isServer

	#

	unless System.findOne { init: true }
		System.insert
			init: true

	#

	Meteor.publish '', ->
		System.find { init: true }
