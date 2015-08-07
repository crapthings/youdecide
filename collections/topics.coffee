#

findUser = (id) ->
	Meteor.users.findOne id,
		fields:
			services: false

#

@Topics = new Mongo.Collection 'topics'

#

Topics.before.insert (userId, topic) ->
	_.extend topic,
		userId: topic.userId or userId
		createdAt: topic.createdAt or new Date()
		stats:
			likes: 0
			comments: 0
			views: 0

#

Topics.after.insert (userId, topic) ->
	System.update { init: true },
		$inc:
			'stats.topics': 1

#

Meteor.methods

	newTopic: (title) ->
		id = Topics.insert
			title: title

#

if Meteor.isServer

	#

	Meteor.publishTransformed 'findTopic', (id) ->
		Topics.find({ _id: id }).serverTransform
			user: (topic) -> findUser topic.userId

	#

	Meteor.publishTransformed 'topicsOfTheDay', (options) ->
		today = new Date()
		startOfDay = moment(today).startOf('day').toDate()
		endOfDay = moment(today).endOf('day').toDate()
		selector = { createdAt: { $gte: startOfDay, $lte: endOfDay } }
		Topics.find(selector, options).serverTransform
			totd: true
			user: (topic) -> findUser topic.userId

	#

	Meteor.publishTransformed 'topicsOfTheMonth', (options) ->
		today = new Date()
		startOfDay = moment(today).startOf('day').toDate()
		endOfDay = moment(today).endOf('day').toDate()
		startOfMonth = moment(today).startOf('month').toDate()
		endOfMonth = moment(today).endOf('month').toDate()
		selector = { createdAt: { $gte: startOfMonth, $lte: startOfDay } }
		Topics.find(selector, options).serverTransform
			totm: true
			user: (topic) -> findUser topic.userId

	#

	Meteor.publishTransformed 'recommendedTopics', (options) ->
		Topics.find({ recommended: true }, options).serverTransform
			user: (topic) -> findUser topic.userId

	#

	Meteor.publishTransformed 'latestTopics', (options) ->
		Topics.find({}, options).serverTransform
			latest: true
			user: (topic) -> findUser topic.userId
