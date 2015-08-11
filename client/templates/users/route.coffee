#

Router.route '/u/v/:userId', ->

	@render 'viewUser',

		data: ->

			topics: Topics.find { userId: @params.userId },
				sort:
					createdAt: -1
				limit: 30
,
	name: 'viewUser'

	waitOn: ->

		subs.subscribe 'findTopics', { userId: @params.userId },
			sort:
				createdAt: -1
			limit: 30
