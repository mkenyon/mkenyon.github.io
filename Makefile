serve: ## Spin up a local server
	bundle exec jekyll serve

draft: ## Spin up a local server that treats your drafts like published posts
	bundle exec jekyll serve --draft

publish: ## Send whatever has been committed to your web server
	git push

install: ## Install ruby dependencies
	gem install bundler:1.17.3 && bundle install

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: serve help
.DEFAULT_GOAL := help
