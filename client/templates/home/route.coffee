#

Router.route '/', ->

	#

	@render 'home',

		#

		data: ->

			#

			latestTopics: ->
				Topics.find { latest: true },
					sort:
						createdAt: -1
					limit: 5

			#

			topicsOfTheDay: ->
				Topics.find { totd: true },
					sort:
						'stats.likes': -1
						'stats.comments': -1
						'stats.views': -1
					limit: 5

			#

			topicsOfTheMonth: ->
				Topics.find { totm: true },
					sort:
						'stats.likes': -1
						'stats.comments': -1
						'stats.views': -1
					limit: 5

			#

			recommendedTopics: ->
				Topics.find { recommended: true },
					sort:
						createdAt: -1
					limit: 5

,

	#

	name: 'home'

	#

	waitOn: -> [

		#

		subs.subscribe 'latestTopics',
			sort:
				createdAt: -1
			limit: 5

		#

		subs.subscribe 'topicsOfTheDay',
			sort:
				'stats.likes': -1
				'stats.comments': -1
				'stats.views': -1
			limit: 5

		#

		subs.subscribe 'topicsOfTheMonth',
			sort:
				'stats.likes': -1
				'stats.comments': -1
				'stats.views': -1
			limit: 5

		#

		subs.subscribe 'recommendedTopics',
			sort:
				createdAt: -1
			limit: 5

	]
