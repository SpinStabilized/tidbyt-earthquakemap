# Makefile for tidbyt-earthquakemap app

# Color formatting variables
blue = \033[0;34m
dark_grey = \033[1;30m
reset = \033[0m

# Enter the name, without extension, of the .star file for the app
tidbyt_app = earthquake_map
star_file = $(blue)$(tidbyt_app).star$(dark_grey)
manifest_file = $(blue)manifest.yaml$(dark_grey)

check: ## Checks if an app is ready to publish
	@echo "$(dark_grey)Checking if $(star_file) and $(manifest_file) are ready for the community repo.$(reset)"
	@pixlet check $(tidbyt_app).star
.PHONY: check

serve: ## Serve a Pixlet app in a web server
	@echo "$(dark_grey)Starting webserver and serving $(star_file).$(reset)"
	@pixlet serve $(tidbyt_app).star
.PHONY: serve

lint: ## Check for linting errors and display proposed changes
	@echo "$(dark_grey)Checking for lint errors in $(star_file) and display the proposed changes.$(reset)"
	@pixlet format --dry-run --verbose $(tidbyt_app).star
.PHONY: lint

clean: lint ## Fix linting issues
	@echo "$(dark_grey)Fix formatting errors in $(star_file) with the linter.$(reset)"
	@pixlet lint --fix $(tidbyt_app).star
.PHONY: clean

gif: ## Generate a gif for sharing
	@echo "$(dark_grey)Generating a gif render of $(star_file) for sharing.$(reset)"
	@pixlet render $(tidbyt_app).star --gif --magnify 10
.PHONY: gif

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
.PHONY: help
.DEFAULT_GOAL = help
