apps = $(wildcard apps/*)

.PHONY: $(MAKECMDGOALS)

default: setup test

# `make setup` will be used after cloning or downloading to fulfill
# dependencies, and setup the the project in an initial state.
# This is where you might download rubygems, node_modules, packages,
# compile code, build container images, initialize a database,
# anything else that needs to happen before your server is started
# for the first time
setupapps = $(apps:%=%/setup)
setup: $(setupapps)

apps/%/setup: force
	@$(MAKE) -C apps/$* setup

# `make server` will be used after `make setup` in order to start
# an http server process that listens on any unreserved port
#	of your choice (e.g. 8080). 
server: force
	@$(MAKE) -C apps/web server

# `make test` will be used after `make setup` in order to run
# your test suite.
testapps = $(apps:%=%/test)
test: $(testapps)

apps/%/test: force
	@$(MAKE) -C apps/$* test

force: ;
