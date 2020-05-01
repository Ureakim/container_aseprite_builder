container_image_name := aseprite_fedora_build

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
full_current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

deps_path := deps/
skia_path := $(deps_path)skia/

.PHONY: deps pull build all clean

all: clean create deps pull build

clean:
	rm -fr $(deps_path)
	rm -fr aseprite

create:
	podman build -t $(container_image_name) .

deps:
	rm -f Skia-Linux-Release-x64.zip
	mkdir $(deps_path)
	mkdir $(skia_path)
	wget https://github.com/aseprite/skia/releases/latest/download/Skia-Linux-Release-x64.zip
	unzip Skia-Linux-Release-x64.zip -d $(skia_path)
	rm Skia-Linux-Release-x64.zip

pull:
	git clone --recursive https://github.com/aseprite/aseprite.git

build: create
	podman run --rm -it --cgroup-manager=systemd --userns keep-id -v $(full_current_dir):/code:Z $(container_image_name)
