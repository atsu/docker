build:
	make -C centosgobuilder
	make -C gobuilder
	make -C alpine
	make -C ansible-playbook

push: build
	make -C centosgobuilder push
	make -C gobuilder push
	make -C alpine push
	make -C ansible-playbook push

clean:
	make -C centosgobuilder clean
	make -C gobuilder clean

.PHONY: build push clean
