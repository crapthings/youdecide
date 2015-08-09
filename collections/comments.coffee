#

@Comments = new Mongo.Collection 'comments'

#

Comments.before.insert (userId, comment) ->
	_.extend comment,
		userId: comment.userId or userId
		createdAt: new Date()

#

Comments.after.insert (userId, comment) ->
	if comment.left
		Topics.update comment.topicId,
			$set:
				left: comment.content
			$inc:
				'stats.left': 1
	else
		Topics.update comment.topicId,
			$set:
				right: comment.content
			$inc:
				'stats.right': 1

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

	Comments.serverTransform (comment) ->
		comment.user = Meteor.users.findOne comment.userId
		return comment

	#

	Meteor.publishTransformed 'findLeftComments', (id, opt = { sort: { createdAt: -1 } }) ->

		check id, String

		Comments.find { topicId: id, left: true }, opt

	#

	Meteor.publishTransformed 'findRightComments', (id, opt = { sort: { createdAt: -1 } }) ->

		check id, String

		Comments.find { topicId: id, left: false }, opt
