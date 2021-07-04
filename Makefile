B=monitor-ping
ARCHS=amd64 arm
ADD_arm=GOARM=5
BINS=$(addprefix $(B)_,$(ARCHS))

all: $(B)

$(B): $(B)_$(shell go env GOARCH)
	ln -sf $< $@

cross: $(BINS)

$(BINS) : $(B)_% : $(B).go
	GOARCH=$* $(ADD_$*) go build -o $@ $<
	sudo setcap cap_net_raw=+ep $@

clean:
	rm -f $(BINS) $(B)

