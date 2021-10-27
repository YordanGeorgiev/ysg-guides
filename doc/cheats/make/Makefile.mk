# how-to include make files 

include lib/make/make-help.mk
 

ifndef VAR_TO_CHECK
$(error VAR_TO_CHECK must be defined)
endif

# cat lib/make/make-help.mk
# usage: include it in your Makefile
# include lib/make/make-help.task

.DEFAULT_GOAL := help

.PHONY: help  ## @-> show this help  the default action
help:
		@clear
		@fgrep -h "##" $(MAKEFILE_LIST)|fgrep -v fgrep|sed -e 's/^\.PHONY: //'|sed -e 's/^\(.*\)##/\1/'| \
      column -t -s $$'@'

# eof cat lib/make/make-help.mk


# usage example
# install-csitea-web: demand_var-ENV demand_var-TGT_ORG do-build-$(component)-docker-img
demand_var-%:
   @if [ "${${*}}" = "" ]; then \
      echo "the var \"$*\" is not set, do set it by: export $*='value'"; \
      exit 1; \
   fi