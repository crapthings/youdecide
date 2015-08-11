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
			likes: topic.stats?.likes or 0
			comments: topic.stats?.comments or 0
			views: topic.stats?.views or 0
			left: topic.stats?.left or 0
			right: topic.stats?.right or 0

#

Topics.after.insert (userId, topic) ->
	System.update { init: true },
		$inc:
			'stats.topics': 1

#

Meteor.methods

	newTopic: (opt) ->
		_opt =
			title: opt.title
			desc: opt.desc

		id = Topics.insert _opt

	findRandomTopic: ->
		countTopic = System.findOne({ init: true }).stats?.topics
		Topics.findOne({}, {skip: _.random 1, countTopic})?._id

	likeTopic: (topicId) ->
		Topics.update topicId,
			$inc:
				'stats.likes': 1

#

if Meteor.isServer

	#

	Topics._ensureIndex { createdAt: -1, 'stats.likes': -1, 'stats.comments': -1, 'stats.views': -1 }

	Topics._ensureIndex { createdAt: -1 }

	Topics._ensureIndex { recommended: 1 }

	#

	Meteor.publishTransformed 'findTopics', (selector, options) ->
		Topics.find(selector, options).serverTransform
			user: (topic) -> findUser topic.userId

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
