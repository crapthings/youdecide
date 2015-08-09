#

faker = Meteor.npmRequire 'faker'

#

collections = Mongo.Collection.getAll()
for collection in collections
	Mongo.Collection.get(collection.name).remove {}

#

Meteor.startup ->

	#

	System.insert
		init: true
		stats:
			users: 0
			topics: 0
			comments: 0

	#

	Accounts.createUser
		username: 'demo'
		password: 'demo'
		profile:
			displayName: '演示用户'
			avatarHash: CryptoJS.MD5('demo').toString()

	#

	_(30).times ->
		username = faker.internet.userName()
		Meteor.users.direct.insert
			username: username
			profile:
				displayName: faker.name.findName()
				avatarHash: CryptoJS.MD5(username).toString()

	#

	users = Meteor.users.find().fetch()

	#

	for user in users

		_(_.random 4, 8).times ->

			topicId = Topics.insert
				userId: user._id
				createdAt: _.sample [ faker.date.recent() ]
				title: faker.lorem.sentence()
				desc: faker.lorem.sentences()
				left: faker.lorem.sentence()
				right: faker.lorem.sentence()
				recommended: _.sample [true, false]
				stats:
					views: _.random 10, 1000
					comments: _.random 10, 1000
					likes: _.random 110, 1000
					left: _.random 10, 1000
					right: _.random 10, 1000

			_(_.random 8, 16).times ->
				Comments.insert
					userId: (_.sample users)._id
					createdAt: _.sample [ faker.date.recent() ]
					topicId: topicId
					content: faker.lorem.sentences()
					left: _.sample [true, false]
