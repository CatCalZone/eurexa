# Eurexa

Eurexa is client library for NetFlix's Eureka service, see https://github.com/Netflix/eureka/wiki/Eureka-REST-operations, written in Elixir.

## Initial Design Ideas

* Eureka has a REST API, which we will use
* Core abstractions of Eurexa are registration of a service, regularly sending
  the heartbeat, deregistration of a service
* Query and metadata update are out of scope for now.
* Eurexa monitors the supervisor of another application, typically 
  this will be a Phoenix app. When it's supervisor stops, Eurexa deregisters
  the service in Eureka.  

## Usage of Eurexa with Phoenix

Start the Eurexa Service as part of the initial supervisor hierarchy of your 
Phoenix application. This ensures that automatically the Eurexa services will 
stop when the entire Phoenix app stops - either voluntarily or because some Phoenix
service fails permanently. In both cases Eurexa will inform the Eureka server 
about the service going down. 

The Eurexa service registers itself as `eurexa` 