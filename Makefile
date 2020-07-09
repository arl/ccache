.PHONY: clean

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Clean go2go generated files and test artifacts
	find src -name '*.go' -delete

gofmt: ## Run gofmt on *.go2 files
	gofmt -s -w main.go2
	gofmt -s -w src/arl.go2/ccache/*.go2
	gofmt -s -w src/arl.go2/ccache/benches/*.go2

test: ## Run ccache benchmarks and generate reports
	cd ./src/arl.go2/ccache/benches && go tool go2go test
	cd ./src/arl.go2/ccache/benches && ./visualize-request.sh request_wikipedia-fifo.txt
	cd ./src/arl.go2/ccache/benches && mv out.png requests.png
	cd ./src/arl.go2/ccache/benches && ./visualize-size.sh size_wikipedia-fifo.txt
	cd ./src/arl.go2/ccache/benches && mv out.png size.png
