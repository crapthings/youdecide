Template.topicItem.rendered = ->

	ctx = ($ @find '.chart')[0].getContext("2d")

	data = [
		{
			value: @data.stats?.left
			color: 'red'
		}
		{
			value: @data.stats?.right
			color: 'blue'
		}
	]

	chart = new Chart(ctx).Pie(data)
