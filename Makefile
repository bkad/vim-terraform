providers := $(wildcard $(GOPATH)/src/github.com/hashicorp/terraform/builtin/providers/*/provider.go)
resource_list := tmp/resources.txt
syntax := syntax/terraform.vim
template_warning := \" GENERATED FROM MAKEFILE, DO NOT EDIT

default: $(syntax)

clean:
	rm $(syntax)
	rm -rf tmp/

$(resource_list): tmp/
	rm -f $(resource_list)
	for file in $(providers); do \
		resource=`grep -E ":\s+resource" "$$file" | cut -f 2 -d '"'`; \
		echo "$$resource" >> $(resource_list); \
	done

$(syntax): $(resource_list)
	echo "$(template_warning)" > $(syntax)
	cat templates/$(syntax) | sed -e 's/RESOURCES/$(shell cat ${resource_list})/' >> $(syntax)

tmp/:
	mkdir -p tmp/

.PHONY: clean default
