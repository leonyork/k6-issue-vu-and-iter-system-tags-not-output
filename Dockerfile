ARG K6_IMAGE=k6
FROM $K6_IMAGE

ARG TEST_FILE=test.js
COPY $TEST_FILE .