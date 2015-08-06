#

faker = Meteor.npmRequire 'faker'

#

System.remove {}
Meteor.users.remove {}
Topics.remove {}
Comments.remove {}

#

Meteor.startup ->

	unless System.findOne()

		System.insert
			init: true
			stats:
				users: 0
				topics: 0

	unless Meteor.users.findOne { username: 'demo' }

		Accounts.createUser
			username: 'demo'
			password: 'demo'

	_(100).times ->
		Meteor.users.insert
			username: faker.internet.userName()
			profile:
				displayName: faker.name.findName()
				avatarUrl: faker.internet.avatar()

	users = Meteor.users.find().fetch()

	for user in users

		_(_.random 10, 20).times ->

			Topics.insert
				userId: user._id
				title: faker.lorem.sentence()
				createdAt: _.sample [ faker.date.recent() ]
				recommended: _.sample [true, false]
				stats:
					views: _.random 100, 1000
					likes: _.random 100, 1000
					comments: _.random 100, 1000
