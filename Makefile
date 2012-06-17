PLATFORM?=native

# Compiler to use for each platform.
CC_native:=gcc
CC_dingux:=mipsel-linux-gcc

# Toolchain base directory for each platform.
TOOLCHAIN_native:=
TOOLCHAIN_dingux:=/opt/opendingux-toolchain

# Executable file extension for each platform.
EXEEXT_native:=
EXEEXT_dingux:=.dge

# Pick the definitions for the active platform.
CC:=$(CC_$(PLATFORM))
TOOLCHAIN:=$(TOOLCHAIN_$(PLATFORM))
EXEEXT:=$(EXEEXT_$(PLATFORM))

CFLAGS:=-O2 -g
LDFLAGS:=

SDL_CONFIG:=$(if $(TOOLCHAIN),$(TOOLCHAIN)/usr/bin/,)sdl-config
CFLAGS+=$(shell $(SDL_CONFIG) --cflags)
LDFLAGS+=$(shell $(SDL_CONFIG) --libs)
LDFLAGS+=-lSDL_mixer

OUTDIR:=output/$(PLATFORM)

SOURCES:=$(wildcard src/*.c)
OBJS:=$(patsubst src/%.c,$(OUTDIR)/obj/%.o,$(SOURCES))

BINARY:=$(OUTDIR)/dist/drill$(EXEEXT)

.PHONY: all dist run clean

all: $(BINARY)

clean:
	rm -rf $(OUTDIR)

dist: $(BINARY)
	mkdir -p $(OUTDIR)/dist/susumi
	mkdir -p $(OUTDIR)/dist/system/bmp
	mkdir -p $(OUTDIR)/dist/system/wav
	cp dat/* $(OUTDIR)/dist
	cp gfx/*.txt $(OUTDIR)/dist
	cp gfx/*.bmp $(OUTDIR)/dist
	cp gfx/susumi/*.bmp $(OUTDIR)/dist/susumi
	cp gfx/susumi/*.txt $(OUTDIR)/dist/susumi
	cp gfx/system/*.bmp $(OUTDIR)/dist/system/bmp
	cp snd/*.txt $(OUTDIR)/dist
	cp snd/wav/*wav $(OUTDIR)/dist/system/wav

run: dist
	cd $(OUTDIR)/dist && ./drill$(EXEEXT)

$(OBJS): $(OUTDIR)/obj/%.o: src/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

$(BINARY): $(OBJS)
	mkdir -p $(@D)
	$(CC) -o $@ $^ $(LDFLAGS)
