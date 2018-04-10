# -
# Setup test requirements
# -

test-setup:
	cd test && sampctl server ensure
	sampctl package ensure

# -
# Run Tests
# -

test-windows:
	cp test/plugins/Debug/uuid.dll test/plugins/uuid.dll
	sampctl package build
	cd test && sampctl server run

test-linux:
	docker build -t southclaws/uuid-build .
	docker run --entrypoint=make southclaws/uuid-build test-linux-inside

test-linux-inside:
	./sampctl package build
	cd test && ../sampctl server run

# -
# Build (Linux)
# -

build-linux:
	rm -rf build
	docker build -t southclaws/uuid-build .
	docker run -v $(shell pwd)/test/plugins:/root/test/plugins southclaws/uuid-build

build-inside:
	cd build && cmake .. && make
