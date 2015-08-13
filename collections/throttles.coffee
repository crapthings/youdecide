#

@Throttles = new Mongo.Collection 'throttles'

Meteor.onConnection (conn) ->
	console.log conn
