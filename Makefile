# Makefile for tidbyt-earthquake app

# Enter the name, without extension, of the .star file for the app
tidbyt_app = earthquake_map
star_file = $(tidbyt_app).star
manifest_file = manifest.yaml

check: ## Checks if an app is ready to publish
	@echo "Checking if $(star_file) and $(manifest_file) are ready for the community repo."
	@pixlet check $(tidbyt_app).star
.PHONY: check

serve: ## Serve a Pixlet app in a web server
	@echo "Starting webserver and serving $(star_file)."
	@pixlet serve $(tidbyt_app).star
.PHONY: serve

lint: ## Check for linting errors and display proposed changes
	@echo "Checking for lint errors in $(star_file) and display the proposed changes."
	@pixlet format --dry-run --verbose $(tidbyt_app).star
.PHONY: lint

clean: lint ## Fix linting issues
	@echo "Fix formatting errors in $(star_file) with the linter."
	@pixlet lint --fix $(tidbyt_app).star
.PHONY: clean

gif: ## Generate a gif for sharing
	@echo "Generating a gif render of $(star_file) for sharing."
	@pixlet render $(tidbyt_app).star --gif --magnify 10
.PHONY: gif

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
.PHONY: help
.DEFAULT_GOAL = help
