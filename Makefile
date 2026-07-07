.PHONY: layers project build-prep

layers:
	./scripts/generate.sh

project: layers
	cd ios && xcodegen generate

build-prep: project
