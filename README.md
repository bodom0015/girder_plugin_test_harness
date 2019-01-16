# Girder Plugin Test Harness

Runs the test suite on the Girder Wholetale Plugin in an isolated environment


## Prerequisites:
* Docker


## Building the Image
Use the usual command to build up our Docker image:
```bash
docker build -t wholetale/girder:test-harness
```
This image contains:
* Python 3.7
* CMake
* Girder 2.5.0 (as source)
* coverage
* flake8


## Running the Container(s)
Now that you have the image built up, we need to take a couple more steps to be able to run it.

### Running MongoDB
While everything else is baked into the Docker image here, we should run an additional container for MongoDB.

You can run an instance MongoDB with the following command:
```bash
docker run -itd --name=test-mongo -p 27101:27017 -v $(pwd)/mongodata/test:/data/db mongo
```
NOTE: We do not use the default port here, but instead use `27101`, as this is how the plugin tests have been configured.


### Running the Tests
Run the following command to build and run the plugin tests:
```bash
docker run --rm -it -v /home/ubuntu/deploy-dev/src/wholetale/:/girder/plugins/wholetale wholetale/girder:test-harness
```
NOTE: Depending on your environment, you may need to specify `--net=host` on the above for your Girder tests to access your test MongoDB instance.
