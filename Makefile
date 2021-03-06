SHELL=/bin/bash
.PHONY: clean snap
default: linux
all: linux windows darwin freebsd


linux: bin/linux-amd64/mdview bin/linux-arm64/mdview bin/linux-i386/mdview
windows: bin/windows-amd64/mdview.exe
darwin: bin/darwin-amd64/mdview
freebsd: bin/freebsd-amd64/mdview

snap:
	snapcraft snap

bin/linux-amd64/mdview:
	env GOOS=linux GOARCH=amd64 go build -o ./bin/linux-amd64/mdview
	tar czvf linux-amd64.tar.gz -C bin/linux-amd64/ mdview
bin/linux-i386/mdview:
	env GOOS=linux GOARCH=386 go build -o ./bin/linux-i386/mdview
	tar czvf linux-i386.tar.gz -C bin/linux-i386/ mdview
bin/linux-arm64/mdview:
	env GOOS=linux GOARCH=arm64 go build -o ./bin/linux-arm64/mdview
	tar czvf linux-arm64.tar.gz -C bin/linux-arm64/ mdview

bin/windows-amd64/mdview.exe:
	env GOOS=windows GOARCH=amd64 go build -o ./bin/windows-amd64/mdview.exe
	zip -j windows-amd64.zip bin/windows-amd64/mdview.exe
bin/darwin-amd64/mdview:
	env GOOS=darwin GOARCH=amd64 go build -o ./bin/darwin-amd64/mdview
	tar czvf darwin-amd64.tar.gz -C bin/darwin-amd64/ mdview
bin/freebsd-amd64/mdview:
	env GOOS=freebsd GOARCH=amd64 go build -o ./bin/freebsd-amd64/mdview
	tar czvf freebsd-amd64.tar.gz -C bin/freebsd-amd64/ mdview

install:
	cp bin/snap/mdview $(DESTDIR)
clean:
	rm -rf ./bin
	rm -f linux-amd64.tar.gz
	rm -f linux-i386.tar.gz
	rm -f linux-arm64.tar.gz

	rm -f freebsd-amd64.tar.gz
	rm -f darwin-amd64.tar.gz
	rm -f windows-amd64.zip

	snapcraft clean mdview -s pull
