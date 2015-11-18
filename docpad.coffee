# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			url: "http://igeorgiev.eu"

			# Here are some old site urls that you would like to redirect from
			oldUrls: [
				'www.website.com',
				'website.herokuapp.com'
			]

			# The default title of our website
			title: "Ivan Georgiev"
            
			# The website description (for SEO)
			description: """
				Professional IT consulting. Proven Data Management expertise. Data integration with DataStage, Hadoop, Hive, Spark, Impala and more. Analytical, Business Intelligence and Data Science solutons.
				"""

			# The website keywords (for SEO) separated by commas
			# The global keywords will appear on each page.
			# Separate individual keywords with comma.
			keywords_global: []

			# The default keywords will appear on pages where no keywords and no tags are defined.
			keywords_default: """
				it,consulting,data management,data architecture
				"""

			# The website author's name
			author: "Your Name"

			# The website author's email
			email: "your@email.com"

			# Styles
			styles: [
				"/ext/bootstrap/css/bootstrap.css"
                "/ext/highlight.js/src/styles/default.css"
				"/css/style.css"
			]

			# Scripts
			scripts: [
				"/ext/jquery-1.11.3.min.js"
				"//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"
				"/ext/bootstrap/js/bootstrap.min.js"
				"/js/app.js"
			]
            



		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords_global.concat(@document.keywords or @document.tags or @site.keywords_default or []).join(', ')


	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		pages: (database) ->
			database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])

		posts: (database) ->
			database.findAllLive({flags:$has:'post'}, [date:-1])



	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()

	plugins:
		livereload:
			enabled: false
}

# Export the DocPad Configuration
module.exports = docpadConfig