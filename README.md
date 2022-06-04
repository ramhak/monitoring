# Factorial Challenge

## Used Technologies
- **Ruby** : 3.1.2
- **Rails** : 7.0.3
- **Apache Kafka**
- [**Karafka**](https://github.com/karafka/karafka)
- **Redis**
- **Postgresql** : 13
- [**asdf**](https://github.com/asdf-vm/asdf)
- [**direnv**](https://direnv.net)

## How Run The Application:
I'm using asdf and direnv for managing my development environment.
After Installing them run this command on the monitoring directory
```console
foo@bar:monitoring$ asdf install 
foo@bar:monitoring$ direnv allow
foo@bar:monitoring$ cd metricvisualizer && direnv allow && cd ..
foo@bar:monitoring$ docker-compose up -d
```
then enter into metricgenerator and run 
```console
foo@bar:metricgenerator$ sidekiq -r ./metric_generator_worker.rb -C config.yml
```
it's a app that used for generating sample metric.

now you can enter into the metricvisualizer directory
and run these commands
```console
foo@bar:metricvisualizer$ bin/dev
foo@bar:metricvisualizer$ bundle exec karafka s
```




