#

Router.route '/recommended', ->

	@render 'recommended',

		data: ->

			recommendedTopics: ->
				Topics.find { recommended: true },
					sort:
						createdAt: -1
					limit: 30
,

	name: 'recommended'

	waitOn: ->

		subs.subscribe 'recommendedTopics',
			sort:
				createdAt: -1
			limit: 30
