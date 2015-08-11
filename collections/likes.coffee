#

@Likes = new Mongo.Collection 'likes'

#

Likes.before.insert (userId, like) ->
	_.extend like,
		userId: userId
		createdAt: new Date()
