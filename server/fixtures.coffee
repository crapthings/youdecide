#

faker = Meteor.npmRequire 'faker'

#

System.remove {}
Meteor.users.remove {}
Topics.remove {}
Comments.remove {}

#

Meteor.startup ->

	#

	unless System.findOne()

		System.insert
			init: true
			stats:
				users: 0
				topics: 0
				comments: 0

	#

	unless Meteor.users.findOne { username: 'demo' }

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

			topicId = Topics.direct.insert
				userId: user._id
				title: faker.lorem.sentence()
				createdAt: _.sample [ faker.date.recent() ]
				recommended: _.sample [true, false]
				left: faker.lorem.sentence()
				right: faker.lorem.sentence()
				stats:
					likes: _.random 100, 1000
					comments: _.random 100, 1000
					views: _.random 100, 1000
					left: _.random 100, 1000
					right: _.random 100, 1000

			_(_.random 8, 16).times ->
				Comments.direct.insert
					userId: user._id
					topicId: topicId
					content: faker.lorem.sentences()
					createdAt: _.sample [ faker.date.recent() ]
					left: _.sample [true, false]
