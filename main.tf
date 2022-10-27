terraform {
# providers/plugins to interact with actual infrastructure
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

# provider configuration/default values
provider "docker" {}

# Based on resource first part harscop will determine and install necessary providers if its offical provider
# Object name should  be unique
# resource <resource name> <object name>
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}

# tfstate file is a private static file used to map local conifugartion file with the deployed infrastructure
# hcl manages the downloaded plugins versions and their sha values

/* general syntax for HCL language

<BLOCK TYPE> [<BLOCK PARAMETER1> <BLOCK PARAMETER2> ...] {
  <ARGUMENT NAME1> = <ARGUMENT VALUE1>
  <ARGUMENT NAME2> = <ARGUMENT VALUE2>
  ....
  <INNER BLOCK> {
      <ARGUMENT NAME1> = <ARGUMENT VALUE1>
      <ARGUMENT NAME2> = <ARGUMENT VALUE2>
  }
}

*/

/* resource sample 

resource "RESOURCE_NAME" "OBJECT_NAME" {
  argument1 = value1
  argument2 = value2
  nested_block1 {
    argument1 = value1
    argument2 = value2
  }
  nested_block2 {
    argument1 = value1
    argument2 = value2
  }
  
*/

