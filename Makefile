providers := $(wildcard $(GOPATH)/src/github.com/hashicorp/terraform/builtin/providers/*/provider.go)
resource_list := tmp/resources.txt

default: $(resource_list)

clean:
	rm -rf tmp/

$(resource_list): tmp/
	echo -n > $(resource_list)
	for file in $(providers); do \
		resource=`grep -E ":\s+resource" "$$file" | cut -f 2 -d '"'`; \
		echo "$$resource" >> $(resource_list); \
	done

tmp/:
	mkdir -p tmp/

.PHONY: clean default
