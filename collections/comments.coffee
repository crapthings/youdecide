#

@Comments = new Mongo.Collection 'comments'

#

Comments.before.insert (userId, comment) ->
	_.extend comment,
		createdAt: new Date()

#

Meteor.methods

	commentLeft: (topicId, content) ->
		Comments.insert
			left: true
			topicId: topicId
			content: content

	commentRight: (topicId, content) ->
		Comments.insert
			left: false
			topicId: topicId
			content: content

#

if Meteor.isServer

	#

	Meteor.publish 'findLeftComments', (topicId) ->
		Comments.find { topicId: topicId, left: true },
			sort:
				createdAt: -1

	#

	Meteor.publish 'findRightComments', (topicId) ->
		Comments.find { topicId: topicId, left: false },
			sort:
				createdAt: -1
