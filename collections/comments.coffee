@Comments = new Mongo.Collection 'comments'

Meteor.methods

	commentLeft: (opt) ->
		Comments.insert
			left: true
			content: opt

	commentRight: (opt) ->
		Comments.insert
			left: false
			content: opt

if Meteor.isServer

	Meteor.publish 'leftComments', ->
		Comments.find {}

	Meteor.publish 'rightComments', ->
		Comments.find {}
