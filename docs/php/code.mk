.PHONY: code.check code.check.dirty code.fix code.fix.dirty code.check.diff code.fix.diff

version ?= 0.2.0
branch ?= develop

ECS_IMAGE := hub.jcdev.net:24000/php-code-analysis-tool:${version}
#ECS_IMAGE := docker.io/library/docker-library-php-code-analysis-tool

# Define default path if one is not passed
ifndef path
	ifneq ("$(wildcard src)","")
		path = src
	else
		path = app config database tests
	endif
endif

ifneq ("$(wildcard ecs.php)","")
    ECS_DR := docker run -it --rm -v "$$PWD":/codebase -v "$$PWD/ecs.php":/app/ecs.php ${ECS_IMAGE} bash
else
    ECS_DR := docker run -it --rm -v "$$PWD":/codebase ${ECS_IMAGE} bash
endif

GIT_DIR = $(shell git rev-parse --show-toplevel)
GIT_DIFF_DIRTY = $(shell git diff --name-only | grep '.php$$')
GIT_DIFF_RANGE=origin/${branch}..HEAD
GIT_DIFF_BRANCH=$(shell git diff --name-only --diff-filter=ACMRTUXB "${GIT_DIFF_RANGE}" | grep '.php$$')

##
# @command code.check 				   Check code in specified path. Usage: `make code.check path=src/app\ src/tests` (src by default)
##
code.check:
	${ECS_DR} \
		-c "ecs check --config /app/ecs.php ${path}"

##
# @command code.fix				   Fix code in specified path. Usage: `make code.fix path=src/app\ src/tests` (src by default)
##
code.fix:
	${ECS_DR} \
		-c "ecs check --fix --config /app/ecs.php ${path}"

##
# @command code.check.dirty			   Check only new code.
##
code.check.dirty:
	@cd ${GIT_DIR} && ${ECS_DR} \
		-c "ecs check --config /app/ecs.php ${GIT_DIFF_DIRTY}"

##
# @command code.fix.dirty			   Fix only new code.
##
code.fix.dirty:
	@cd ${GIT_DIR} && ${ECS_DR} \
		-c "ecs check --fix --config /app/ecs.php ${GIT_DIFF_DIRTY}"

##
# @command code.check.diff			   Check only diff files from target branch. Usage: `make code.check.diff branch=main` (develop by default)
##
code.check.diff:
	cd ${GIT_DIR} && ${ECS_DR} \
		-c "ecs check --config /app/ecs.php ${GIT_DIFF_BRANCH}"

##
# @command code.fix.diff			   Fix only diff files from target branch. Usage: `make code.fix.diff branch=main` (develop by default)
##
code.fix.diff:
	cd ${GIT_DIR} && ${ECS_DR} \
		-c "ecs check --fix --config /app/ecs.php ${GIT_DIFF_BRANCH}"

##
# @command code.config.publish		   Publish ecs.php configuration file to override default one.
##
code.config.publish:
	@echo '...........Publishing config'
	@$(eval CONTAINER_ID = $(shell docker create hub.jcdev.net:24000/php-code-analysis-tool:latest))
	@docker cp ${CONTAINER_ID}:/app/ecs.php ecs.php
	@docker rm -v ${CONTAINER_ID}
	@echo '...........Published "ecs.php"'
