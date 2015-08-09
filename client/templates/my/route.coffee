Router.route '/my', ->
	@render 'my',
		data: ->
			topics: Topics.find { userId: Meteor.userId() }, { sort: { createdAt: -1 } }
,
	name: 'my'
	waitOn: ->
		subs.subscribe 'findTopics', { userId: Meteor.userId() }, { sort: { createdAt: -1 }, limit: 30 }
