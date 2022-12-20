all: working issue 
	-make diff-vu
	-make diff-iter

working: 	
	docker build --build-arg K6_IMAGE=loadimpact/k6:0.40.0 -t k6 .
	docker run -v "$(CURDIR)"/results:/results k6 run test.js -o csv=/results/working.csv

issue: 	
	docker build --build-arg K6_IMAGE=loadimpact/k6:0.42.0 -t k6 .
	docker run -v "$(CURDIR)"/results:/results k6 run test.js -o csv=/results/broken.csv

diff-vu:
	@echo '******************************'
	@echo '* Diff of VU column          *'
	@echo '******************************'
	@awk -F "\"*,\"*" '{print $$5}' results/broken.csv > results/broken-vu.csv
	@awk -F "\"*,\"*" '{print $$5}' results/working.csv > results/working-vu.csv
	@diff -u results/working-vu.csv results/broken-vu.csv

diff-iter:
	@echo '******************************'
	@echo '* Diff of iter column        *'
	@echo '******************************'
	@awk -F "\"*,\"*" '{print $$4}' results/broken.csv > results/broken-iter.csv
	@awk -F "\"*,\"*" '{print $$4}' results/working.csv > results/working-iter.csv
	@diff -u results/working-iter.csv results/broken-iter.csv