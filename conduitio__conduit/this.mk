### bin

# MUST tag go build so it gets included.
BASE_BIN_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -tags ui

this-bin-pre:
	# MUST call their make yarn.
	# https://classic.yarnpkg.com/en/docs/install#mac-stable

	$(BASE_SRC_CMD) cd ui && npm install --global yarn
	$(BASE_SRC_CMD) cd ui && $(MAKE) dist



THIS_DATA_PATH=$(BASE_CWD_DATA)

THIS_DB_NAME=conduit_db
THIS_DB_PATH=$(THIS_DATA_PATH)/$(THIS_DB_NAME)

THIS_PROCESSOR_NAME=processors
THIS_PROCESSOR_PATH=$(THIS_DATA_PATH)/$(THIS_PROCESSOR_NAME)

THIS_PIPELINE_NAME=pipelines
THIS_PIPELINE_PATH=$(THIS_DATA_PATH)/$(THIS_PIPELINE_NAME)

THIS_RUN_CMD=$(BASE_BIN_TARGET) -db.badger.path=$(THIS_DB_PATH) -processors.path=$(THIS_PROCESSOR_PATH)



### start

this-start:
	# http://localhost:8080/ui
	# http://localhost:8080/openapi
	$(THIS_RUN_CMD) .
	

### run 

this-run-h:
	$(THIS_RUN_CMD) -h

this-run-dep-del:
	rm -rf $(THIS_PROCESSOR_PATH)
	rm -rf $(THIS_PIPELINE_PATH)

this-run-dep:
	# Need to get the processors into the right folders.
	# Eventually NATS will do this shit for me.

	mkdir -p $(THIS_PROCESSOR_PATH)
	@echo $(THIS_PROCESSOR_NAME) >> .gitignore

	# grab out of other Proejcts....

	cp ./../conduitio__conduit-connector-file/.bin/* $(THIS_PROCESSOR_PATH)

	cp ./../conduitio__conduit-connector-s3/.bin/* $(THIS_PROCESSOR_PATH)

	cp ./../conduitio-labs__conduit-connector-google-sheets__connector/.bin/* $(THIS_PROCESSOR_PATH)

	mkdir -p $(THIS_PIPELINE_PATH)
	@echo $(THIS_PIPELINE_NAME) >> .gitignore

this-run-version:
	$(BASE_BIN_TARGET) -version

