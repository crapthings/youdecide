#

Router.route '/latest', ->

	@render 'latest',

		data: ->

			latestTopics: ->
				Topics.find { latest: true },
					sort:
						createdAt: -1
					limit: 30
,

	name: 'latest'

	waitOn: ->

		subs.subscribe 'latestTopics',
			sort:
				createdAt: -1
			limit: 30
