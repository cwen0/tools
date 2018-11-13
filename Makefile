GO=GO15VENDOREXPERIMENT="1" CGO_ENABLED=0 go
GO_CGO=GO15VENDOREXPERIMENT="1" CGO_ENABLED=1 go
GORACE=CGO_ENABLED=1 go build -race
GOTEST=GO15VENDOREXPERIMENT="1" CGO_ENABLED=1 go test # go race detector requires cgo

PACKAGES := $$(go list ./...| grep -vE 'vendor')

GOFILTER := grep -vE 'vendor|render.Delims|bindata_assetfs|testutil'
GOCHECKER := $(GOFILTER) | awk '{ print } END { if (NR > 0) { exit 1 } }'

GOBUILD=$(GO) build
GOBUILD_CGO=$(GO_CGO) build -ldflags '$(LDFLAGS)'

empty:
	$(GOBUILD) -o bin/empty empty_case/*.go
